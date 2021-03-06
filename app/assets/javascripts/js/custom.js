$(document).ready(function () {
  "use strict";
  // ------------------------------------------------------- //
  // Calendar
  // ------------------------------------------------------ //
  $(document).on("turbolinks:load", function () {
    $("#calendar").each(function () {
      var calendar = $(this);
      calendar.fullCalendar({
        themeSystem: "bootstrap4",
        displayEventTime: true,
        timeFormat: "HH:mm",
        businessHours: false,
        defaultView: "agendaWeek",
        editable: true,
        selectHelper: true,
        selectable: true,
        ignoreTimezone: false,
        snapDuration: "00:30:00",
        header: {
          left: "title",
          center: "month,agendaWeek,agendaDay",
          right: "today prev,next",
        },
        events: "/events.json",

        select: function (start, end) {
          $.getScript("/events/new", function () {
            $("datetimepicker7").datetimepicker({});
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

        eventResize: function (event) {
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
            element.find(".fc-time").append(
              // 開発環境用パス
              // "<img src=/assets/" + event.icon + ' class="event-img"/>'
              // デプロイ用パス
              '<img src=/images/' + event.icon + ' class="event-img"/>'
            );
          }
        },
      });
    });
  });
});

// ------------------------------------------------------- //
// Chart
// ------------------------------------------------------ //
$(document).on("turbolinks:load", function () {
  function allRemove() {
    $("#milk-graph").hide();
    $("#breastfeeding-graph").hide();
    $("#poo-graph").hide();
    $("#pee-graph").hide();
  };

  allRemove();
  $("#milk-graph").show();
  $(".switch-graph").click(function () {
    allRemove();
    $("#" + $(this).attr("id") + "-graph").show();
  });
});
