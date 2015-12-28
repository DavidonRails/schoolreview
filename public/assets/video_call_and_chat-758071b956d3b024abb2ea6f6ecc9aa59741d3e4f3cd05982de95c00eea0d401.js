    var mediaParams, caller, callee;
    QB.init(QBApp.appId, QBApp.authKey, QBApp.authSecret, CONFIG);

    var currentUser;

    $(document).ready(function(){
        $(function () {

            caller = {
              id :  window.current_user_qb_id,
              full_name : window.current_user_name,
              login : window.current_user_email,
              password : "quickblox_common_password"
            };

            currentUser = {
              id: caller.id,
              name: caller.full_name,
              login: caller.login,
              pass: caller.password
            };
            
            //if current user has been login to quickblox
            if(caller.login != undefined) {
              var login = caller.login;
              var password = "quickblox_common_password";

              var caller_for_sesson = { 'login': login, 'password': password};
              
              QB.createSession(caller_for_sesson, function(err, res) {
                if (res) {
                  token = res.token;

                  chat_id = res.user_id;

                  console.log("User Chat ID", chat_id);

                  QB.login(caller, function(err, user){
                    if (user) {
                      console.log("qb user success", JSON.stringify(user));

                      QB.chat.connect(
                        { userId: chat_id,  password: caller.password}, 
                        function(err, roster) {
                          if (err) {
                            console.log(err);
                          } else {
                            
                            console.log(roster);

                            retrieveChatDialogs();

                            console.log("chat dialog lists: ", dialogs);

                            setupAllChatListeners();
                          }
                        }
                      );

                    } else {
                      console.log("Quickblox Login Error", err);
                    }
                  });
                
                } else {
                  console.log("Quickblox Create Session Error", err);
                }
              });
            }

            function setupAllChatListeners() {
              QB.chat.onDisconnectedListener    = onDisconnectedListener;
              QB.chat.onReconnectListener       = onReconnectListener;
              QB.chat.onMessageListener         = onMessage;
              QB.chat.onSystemMessageListener   = onSystemMessageListener;
              QB.chat.onDeliveredStatusListener = onDeliveredStatusListener;
              QB.chat.onReadStatusListener      = onReadStatusListener;
            }

            $(".pat_msg").click(function(e) {
              if(caller.login == undefined) {
                alert("You don't have quickblox id to send message!");
                return;
              }

              opponentId = $(this).attr("qb_id");
              opponentLogin = $(this).attr("qb_email");
              opponentName = $(this).attr("qb_name");

              if(opponentId === "") {
                alert("Sorry! " + opponentName + " has no Quickblox ID for chat service!");
                return;
              }

              $(".modal-title").html("Send Message to " + opponentName);

              $(".income_box").css("display", "none");
              $(".income_box .income_user").html('');
              $(".income_box .income_msg_text").val('');

              $('#chatDlg .msg_text').val('');
              $('#chatDlg').modal('show');
              
            });

            $(".msg_send_btn").click(function(e) {
              var currentText = $('.msg_text').val().trim();
              if (currentText.length === 0){
                return;
              }

              $('.msg_text').val('').focus();

              var usersIds = [];
              var usersNames = [];

              //sender
              // usersIds[0] = caller.id;
              // usersNames[0] = caller.login;
              //receiver
              usersIds[0] = opponentId;
              usersNames[0] = opponentLogin;

              var dialogName;
              var dialogOccupants;
              var dialogType;

              if (usersNames.indexOf(caller.login) > -1) {
                dialogName = usersNames.join(', ');
              }else{
                dialogName = caller.login + ', ' + usersNames.join(', ');
              }

              dialogOccupants = usersIds;
              dialogType = 3;

              var params = {
                type: dialogType,
                occupants_ids: dialogOccupants,
                name: dialogName
              };

              // create a dialog
              //
              console.log("Creating a dialog with params: " + JSON.stringify(params));
              
              QB.chat.dialog.create(params, function(err, createdDialog) {
                if (err) {
                  console.log(err);
                } else {
                  console.log("Dialog " + createdDialog._id + " created with users: " + dialogOccupants);

                  // save dialog to local storage
                  var dialogId = createdDialog._id;
                  dialogs[dialogId] = createdDialog;

                  currentDialog = createdDialog;

                  // joinToNewDialogAndShow(createdDialog);

                  notifyOccupants(createdDialog.occupants_ids, createdDialog._id, 1);

                  triggerDialog(createdDialog._id);

                  sendMessage(currentText, null);

                }
              });

            
            });

            $('.slider1').anyslider({
                animation: 'slide',
                interval: 0,
                reverse: true,
                keyboard: false,
                speed: 1500
            });

            $('#tabs a').click(function(e) {
                e.preventDefault();
                $(this).tab('show');

            });

            $('.institution_search_btn').click(function(e) {
                var key = $('.institution_search_word').val();
                console.log("institution search button clicked!");
                if(key == "") {
                  alert('Please input institution program for user search');
                } else {
                  $.ajax({
                       type:'POST',
                       dataType: "json",
                       url: '/users/program_search', 
                       data: $.param({ program: key }),
                       success: function(data) {
                          render_user_search_list(data);
                       },
                       error: function(err) {
                          alert("Internal Server Error!");
                       }
                  });
                }
                
            });

            $('.username_search_btn').click(function(e) {
                var key = $('.username_search_word').val();
                console.log("username search button clicked!")
                if(key == "") {
                  alert('Please input username for user search');
                } else {
                  $.ajax({
                       type:'POST',
                       dataType: "json",
                       url: '/users/name_search', 
                       data: $.param({ username: key }),
                       success: function(data) {
                          render_user_search_list(data);
                       },
                       error: function(err) {
                          alert("Internal Server Error!");
                       }
                  });
                }
                
            });
            $('.location_search_btn').click(function(e) {
                var key = $('.location_search_word').val();

                if(key == "") {
                  alert('Please input location for user search');
                } else {
                  $.ajax({
                       type:'POST',
                       dataType: "json",
                       url: '/users/location_search', 
                       data: $.param({ location: key }),
                       success: function(data) {
                          render_user_search_list(data);
                       },
                       error: function(err) {
                          alert("Internal Server Error!");
                       }
                  });
                }

            });

            $('.description_search_btn').click(function(e) {
                var key = $('.description_search_word').val();

                if(key == "") {
                  alert('Please input description for user search');
                } else {
                  $.ajax({
                       type:'POST',
                       dataType: "json",
                       url: '/users/desc_search', 
                       data: $.param({ description: key }),
                       success: function(data) {
                          render_user_search_list(data);
                       },
                       error: function(err) {
                          alert("Internal Server Error!");
                       }
                  });
                }
            });

            function render_user_search_list(lists) {
              var html = "";
              
              for(var item in lists) {
                var username = lists[item].first_name + ' ' + lists[item].last_name;
                var current_user_email = $(".current_user_email").val();
                var qb_id = lists[item].qb_id;
                var qb_email  = lists[item].email;
                var me = false;

                html += 
                    '<div class="panel search_item_panel">' +
                      '<div class="panel-heading clickable panel-collapsed" user_id="' + lists[item].id + '">' +
                        '<div class="col-md-3 user_name">' + lists[item].first_name + ' ' + lists[item].last_name + '</div>' +
                        '<div class="col-md-3 user_major">Math</div>' +
                        '<div class="col-md-3 user_location">Copenhagen, Denmark</div>' +
                        '<div class="col-md-3 user_action">' +
                          '<span class="like_btn unlike"></span>' +
                          '<span class="down_arrow arrow_span"></span>' +
                        '</div>' +
                      '</div>' +
                      '<div class="panel-body" style="display:none;">' +
                        '<div class="col-md-4">' +
                          '<div class="col-md-6">' +
                            '<p>Personal Description:</p>' +
                            '<img class="user_avatar" src=  "' + lists[item].profile_photo.url + '" width="80" height="100">' +
                          '</div>' +

                          '<div class="col-md-6 user_desc">' +
                            lists[item].description +
                          '</div>' +

                        '</div>' +

                        '<div class="col-md-8 user_institutions">' +
                          '<div class="col-md-8">' +
                            '<div class="institution_row">' +
                              '<p>Institution: Brown unityversity</p>' +
                              '<p>Program: PRMICG(Master of Science)</p>' +
                              '<p>Duration: August 2014 - May 2015</p>' +
                            '</div>' +

                            '<div class="institution_row">' +
                              '<p>Institution: Harvard unityversity</p>' +
                              '<p>Program: Supply Chain Management(Bachelor of Art)</p>' +
                              '<p>Duration: August 2014 - June 2015</p>' +
                            '</div>' +
                          '</div>' +

                          '<div class="col-md-4">';
                if(lists[item].email != current_user_email) {
                  html +=    '<a class="call_btn" data-toggle="modal" data-target="#video_conf_modal" qb_name="' + username + '" qb_id="' + qb_id  + '" qb_email="' + qb_email + '" onclick="video_call(this);"></a>';
                }
                  html += '</div>' +

                        '</div>' +
                      '</div>' +
                    '</div>';
              }

              if(html) {
                $('.user_search_table').html(html);

                $('.panel-heading.clickable').on("click", function (e) {
                    if ($(this).hasClass('panel-collapsed')) {
                        // expand the panel
                        $(this).parents('.panel').find('.panel-body').slideDown();
                        $(this).removeClass('panel-collapsed');
                        $(this).find('.arrow_span').removeClass('down_arrow').addClass('up_arrow');
                    } else {
                        // collapse the panel
                        $(this).parents('.panel').find('.panel-body').slideUp();
                        $(this).addClass('panel-collapsed');
                        $(this).find('.arrow_span').removeClass('up_arrow').addClass('down_arrow');
                    }
                });

                $('.user_search_list').show();
              } else {
                alert("Sorry! There is no matched search result!");
              }

            }

            $('.panel-heading.clickable').on("click", function (e) {
                if ($(this).hasClass('panel-collapsed')) {
                    // expand the panel
                    $(this).parents('.panel').find('.panel-body').slideDown();
                    $(this).removeClass('panel-collapsed');
                    $(this).find('.arrow_span').removeClass('down_arrow').addClass('up_arrow');
                }
                else {
                    // collapse the panel
                    $(this).parents('.panel').find('.panel-body').slideUp();
                    $(this).addClass('panel-collapsed');
                    $(this).find('.arrow_span').removeClass('up_arrow').addClass('down_arrow');
                }
            });

            // Accept call
            //
            $('#accept').click(function() {
              $('#incomingCall').modal('hide');
              $('#video_conf_modal').modal('show');
              $('#ringtoneSignal')[0].pause();

              QB.webrtc.getUserMedia(mediaParams, function(err, stream) {
                if (err) {
                  console.log(err);
                  var deviceNotFoundError = 'Devices are not found';
                  alert(deviceNotFoundError);

                  QB.webrtc.reject(callee.id, {'reason': deviceNotFoundError});
                } else {
                  // $('.btn_mediacall, #hangup').removeAttr('disabled');
                  // $('#audiocall, #videocall').attr('disabled', 'disabled');

                  QB.webrtc.accept(callee.id);
                }
              });
            });


            // Reject
            //
            $('#reject').click(function() {
              $('#incomingCall').modal('hide');
              $('#ringtoneSignal')[0].pause();

              if (typeof callee != 'undefined'){
                QB.webrtc.reject(callee.id);
              }
            });


            // Hangup
            //
            $('#hangup').click(function(e) {
              alert("hang up!");
              if (typeof callee != 'undefined'){
                $('#video_conf_modal').modal('hide');
                QB.webrtc.stop(callee.id);
              }
            });


            // Mute camera
            //
            $('.btn_camera_off').click(function() {
              var action = $(this).data('action');
              if (action === 'mute') {
                $(this).addClass('off').data('action', 'unmute');
                QB.webrtc.mute('video');
              } else {
                $(this).removeClass('off').data('action', 'mute');
                QB.webrtc.unmute('video');
              }
            });


            // Mute microphone
            //
            $('.btn_mic_off').click(function() {
              var action = $(this).data('action');
              if (action === 'mute') {
                $(this).addClass('off').data('action', 'unmute');
                QB.webrtc.mute('audio');
              } else {
                $(this).removeClass('off').data('action', 'mute');
                QB.webrtc.unmute('audio');
              }
            });
        });
    });

    function video_call(e) {
      var qb_id = e.getAttribute("qb_id");
      var qb_name = e.getAttribute("qb_name");
      var qb_email = e.getAttribute("qb_email");

      alert("Your call id is " + qb_id);

      if(qb_id == "null") {
        alert("Sorry! " + e.getAttribute("qb_name") + " has no connection for video conference!");
      } else {
        callee = {
          id: qb_id,
          full_name: qb_name,
          login: qb_email,
          password: "quickblox_common_password"
        };
      
        mediaParams = {
          audio: true,
          video: true,
          elemId: 'localVideo',
          options: {
            muted: true,
            mirror: true
          }
        };
        
        callWithParams(mediaParams, true, qb_id);
      }
  }

  function callWithParams(mediaParams, isOnlyAudio, qb_id){
    QB.webrtc.getUserMedia(mediaParams, function(err, stream) {
      if (err) {
        console.log(err);
        alert('Error: devices (camera or microphone) are not found');
      } else {
        console.log('Calling...');
        QB.webrtc.call(qb_id, isOnlyAudio ? 'audio' : 'video', {});
      }
    });
  }

  function hungUp(){
    // hide inciming popup if it's here
    $('#incomingCall').modal('hide');
    $('#video_conf_modal').modal('hide');
    $('#ringtoneSignal')[0].pause();

    alert('Call is stopped. Logged in as ' + caller.full_name);

    // $('.btn_mediacall, #hangup').attr('disabled', 'disabled');
    // $('#audiocall, #videocall').removeAttr('disabled');
    $('video').attr('src', '');
    $('#callingSignal')[0].pause();
    $('#endCallSignal')[0].play();
  }

  //
  // Callbacks
  //

  QB.webrtc.onSessionStateChangedListener = function(newState, userId) {
    console.log("onSessionStateChangedListener: " + newState + ", userId: " + userId);

    // possible values of 'newState':
    //
    // QB.webrtc.SessionState.UNDEFINED
    // QB.webrtc.SessionState.CONNECTING
    // QB.webrtc.SessionState.CONNECTED
    // QB.webrtc.SessionState.FAILED
    // QB.webrtc.SessionState.DISCONNECTED
    // QB.webrtc.SessionState.CLOSED

    if(newState === QB.webrtc.SessionState.DISCONNECTED){
      if (typeof callee != 'undefined'){
        QB.webrtc.stop(callee.id);
      }
      hungUp();
    }else if(newState === QB.webrtc.SessionState.CLOSED){
      hungUp();
    }
  };

  QB.webrtc.onCallListener = function(userId, extension) {
    console.log("onCallListener. userId: " + userId + ". Extension: " + JSON.stringify(extension));

    mediaParams = {
      audio: true,
      video: true,
      elemId: 'localVideo',
      options: {
        muted: true,
        mirror: true
      }
    };

    // save a callee
    callee = {
      id: extension.callerID,
      full_name: "User with id " + extension.callerID,
      login: "",
      password: ""
    };

    $('.caller').text(callee.full_name);

    $('#ringtoneSignal')[0].play();

    $('#incomingCall').modal({
      backdrop: 'static',
      keyboard: false
    });
  };

  QB.webrtc.onAcceptCallListener = function(userId, extension) {
    console.log("onAcceptCallListener. userId: " + userId + ". Extension: " + JSON.stringify(extension));

    $('#callingSignal')[0].pause();
    alert(callee.full_name + ' has accepted this call');
  };

  QB.webrtc.onRejectCallListener = function(userId, extension) {
    console.log("onRejectCallListener. userId: " + userId + ". Extension: " + JSON.stringify(extension));

    // $('.btn_mediacall, #hangup').attr('disabled', 'disabled');
    // $('#audiocall, #videocall').removeAttr('disabled');
    $('video').attr('src', '');
    $('#callingSignal')[0].pause();
    alert(callee.full_name + ' has rejected the call. Logged in as ' + caller.full_name);
  };

  QB.webrtc.onStopCallListener = function(userId, extension) {
    console.log("onStopCallListener. userId: " + userId + ". Extension: " + JSON.stringify(extension));

    hungUp();
  };

  QB.webrtc.onRemoteStreamListener = function(stream) {
    QB.webrtc.attachMediaStream('remoteVideo', stream);
  };

  QB.webrtc.onUserNotAnswerListener = function(userId) {
    console.log("onUserNotAnswerListener. userId: " + userId);    
  };



























