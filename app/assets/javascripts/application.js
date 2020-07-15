// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require turbolinks
//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require popper
//= require moment
//= require moment/ja.js
//= require chartkick
//= require Chart.bundle
//= require_tree .

$(document).ready(function () {
  "use strict";
  // ------------------------------------------------------- //
  // Calendar
  // ------------------------------------------------------ //
  var initialize_calendar = function () {
    $("#calendar").each(function () {
      var calendar = $(this);
      calendar.fullCalendar({
        themeSystem: "bootstrap4",
        displayEventTime: true,
        // displayEventEnd: {
        //   month: true,
        //   basicWeek:true,
        //   "Default": true
        // },
        timeFormat: "HH:mm",
        businessHours: false,
        defaultView: "month",
        editable: true,
        events: "/events.json",
        selectHelper: true,
        selectable: true,
        ignoreTimezone: false,
        snapDuration: "00:15:00",
        header: {
          left: "title",
          center: "month,agendaWeek,agendaDay",
          right: "today prev,next",
        },
        events: "/events.json",

        select: function (start, end) {
          $.getScript("/events/new", function () {
            $("datetimepicker7").datetimepicker({
              // useCurrent: false,
              // slideBySide: true,
            });
            $("#datetimepicker8").datetimepicker({
              useCurrent: false,
            });
            $("#datetimepicker7").on("change.datetimepicker", function (start) {
              $("#datetimepicker8").datetimepicker("minDate", start.date);
            });
            $("#datetimepicker8").on("change.datetimepicker", function (end) {
              $("#datetimepicker7").datetimepicker("maxDate", end.date);
            });
            $(".input-start").val(moment(start).format("YYYY-MM-DD HH:mm"));
            $(".input-end").val(moment(end).format("YYYY-MM-DD HH:mm"));
          }),
            calendar.fullCalendar("unselect");
        },

        eventDrop: function (event) {
          var event_data = {
            event: {
              id: event.id,
              start: event.start.format(),
              end: event.end.format(),
            },
          };
          var update_url = "/events/" + event.id;
          $.ajax({
            url: update_url,
            data: event_data,
            type: "PATCH",
          });
        },

        eventClick: function (event, jsEvent, view) {
          var edit_url = "/events/" + event.id + "/edit";
          $.getScript(edit_url, function () {
            $("#datetimepicker7").datetimepicker();
            $("#datetimepicker8").datetimepicker({
              useCurrent: false,
            });
            $("#datetimepicker7").on("change.datetimepicker", function (start) {
              $("#datetimepicker8").datetimepicker("minDate", start.date);
            });
            $("#datetimepicker8").on("change.datetimepicker", function (end) {
              $("#datetimepicker7").datetimepicker("maxDate", end.date);
            });
          });
        },

        eventRender: function (event, element, start, end) {
          if (event.icon) {
            element
              .find(".fc-time")
              .append(
                '<img src=/assets/' + event.icon + ' class="event-img"/>'

                // デプロイ用パス
                // '<img src=/images/' + event.icon + ' class="event-img"/>'
              );
          }
        },
      });
    });
  };
  $(document).on("turbolinks:load", initialize_calendar);

  
});

  // ------------------------------------------------------- //
  // Chart
  // ------------------------------------------------------ //

$(document).ready(function () {
  function allRemove() {
    $('#milk-graph').hide();
    $('#pee-graph').hide();
    $('#poo-graph').hide();
  };

  allRemove();
  $('#milk-graph').show();

  $('.switch-graph').click(function() { 
    allRemove();
    $('#'+$(this).attr('id')+'-graph').show();
  }); 
});