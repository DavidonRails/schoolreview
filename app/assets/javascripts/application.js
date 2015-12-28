// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require jquery.timeago.js
//= require jquery.nicescroll.min.js
//= require foundation
//= require redactor/redactor
//= require highcharts/highcharts.js
//= require highcharts/highcharts-more.js
//= require highcharts/exporting.js
//= require highcharts/themes/sand-signika.js
//= require typeahead.js
//= require chosen/chosen.jquery.js
//= require bootstrap
//= require bootstrap-sprockets

//= require quickblox.min.js
//= require config.js

//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ready(function() {

	setTimeout(function(){
		$("#layout-flash-box").fadeOut("slow", function() {
		  $(this).remove();
		})
	}, 4500);

	
});
