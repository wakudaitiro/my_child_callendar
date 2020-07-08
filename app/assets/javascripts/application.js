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
        // emphasizes business hours
        businessHours: false,
        defaultView: "month",
        // event dragging & resizing
        editable: true,
        events: "/events.json",
        selectHelper: true,
        selectable: true,
        ignoreTimezone: false,
        snapDuration: "00:15:00",
        

        // header
        header: {
          left: "title",
          center: "month,agendaWeek,agendaDay",
          right: "today prev,next",
        },
        events: "/events.json",

        select: function (start, end) {
          $.getScript("/events/new", function () {
            $("datetimepicker7").datetimepicker({
              useCurrent: false,
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
          // $.getScript(event.edit_url, function() {
          //   $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
          //   $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
          //   $(".event-icon").html("<i class='fa fa-" + event.icon + "'></i>");
          //   $(".event-title").html(event.title);
          //   $("#modal-view-event").modal();
          // });

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

        
        eventRender: function (event, element) {
          if (event.icon) {
            element
            .find(".fc-title")
            .prepend(
              '<img src=' + event.icon + ' class="event-img"/>'
              );
            }
          },
          
          displayEventTime: true,
          // displayEventEnd: {
          //   month: true,
          //   basicWeek:true,
          //   "Default": true
          // },
          timeFormat: "HH:mm",
          
          
        });
      });
    };
    $(document).on("turbolinks:load", initialize_calendar);
  });
  
  
  
  //         events: [
  //   {
  //     title: "Barber",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2020-07-07T14:00:00",
  //     end: "2020-07-07T15:00:00",
  //     className: "fc-bg-default",
  //     icon: "https://img.icons8.com/plasticine/100/000000/milk-bottle.png",
  //   },
  //   {
  //     title: "Flight Paris",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2020-07-08T14:00:00",
  //     end: "2020-07-08T20:00:00",
  //     className: "fc-bg-deepskyblue",
  //     icon: "cog",
  //     allDay: false,
  //   },
  //   {
  //     title: "Team Meeting",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2020-07-10T13:00:00",
  //     end: "2020-07-10T16:00:00",
  //     className: "fc-bg-pinkred",
  //     icon: "group",
  //     allDay: false,
  //   },
  //   {
  //     title: "Meeting",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-08-12",
  //     className: "fc-bg-lightgreen",
  //     icon: "suitcase",
  //   },
  //   {
  //     title: "Conference",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-08-13",
  //     end: "2019-08-15",
  //     className: "fc-bg-blue",
  //     icon: "calendar",
  //   },
  //   {
  //     title: "Baby Shower",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2020-07-13",
  //     end: "2020-07-14",
  //     className: "fc-bg-default",
  //     icon: "child",
  //   },
  //   {
  //     title: "Birthday",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-09-13",
  //     end: "2019-09-14",
  //     className: "fc-bg-default",
  //     icon: "birthday-cake",
  //   },
  //   {
  //     title: "Restaurant",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-10-15T09:30:00",
  //     end: "2019-10-15T11:45:00",
  //     className: "fc-bg-default",
  //     icon: "glass",
  //     allDay: false,
  //   },
  //   {
  //     title: "Dinner",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-11-15T20:00:00",
  //     end: "2019-11-15T22:30:00",
  //     className: "fc-bg-default",
  //     icon: "cutlery",
  //     allDay: false,
  //   },
  //   {
  //     title: "Shooting",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-08-25",
  //     end: "2019-08-25",
  //     className: "fc-bg-blue",
  //     icon: "camera",
  //   },
  //   {
  //     title: "Go Space :)",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-12-27",
  //     end: "2019-12-27",
  //     className: "fc-bg-default",
  //     icon: "rocket",
  //   },
  //   {
  //     title: "Dentist",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2019-12-29T11:30:00",
  //     end: "2019-12-29T012:30:00",
  //     className: "fc-bg-blue",
  //     icon: "medkit",
  //     allDay: false,
  //   },
  //   {
  //     title: "Dentist",
  //     description:
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
  //     start: "2020-06-27T11:30:00",
  //     end: "2020-06-28T012:30:00",
  //     className: "fc-bg-blue",
  //     icon: "medkit",
  //     allDay: false,
  //   },
  // ],
//   eventAfterRender: function(event, element, view) {
//     $(element).css('width','50%');
//  },
  
  
  //   $(function () {
    //     // page is ready
//     $("#calendar").fullCalendar({
//       themeSystem: "bootstrap4",
//       // emphasizes business hours
//       businessHours: false,
//       defaultView: "month",
//       // event dragging & resizing
//       editable: true,
//       events: "/events.json",
//       selectHelper: true,
//       selectable: true,
//       ignoreTimezone: false,
//       // header
//       header: {
//         left: "title",
//         center: "month,agendaWeek,agendaDay",
//         right: "today prev,next",
//       },
//       events: [
//         {
//           title: "Barber",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-07-07T14:00:00",
//           end: "2019-07-07T15:00:00",
//           className: "fc-bg-default",
//           icon: "circle",
//         },
//         {
//           title: "Flight Paris",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-08-08T14:00:00",
//           end: "2019-08-08T20:00:00",
//           className: "fc-bg-deepskyblue",
//           icon: "cog",
//           allDay: false,
//         },
//         {
//           title: "Team Meeting",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-07-10T13:00:00",
//           end: "2019-07-10T16:00:00",
//           className: "fc-bg-pinkred",
//           icon: "group",
//           allDay: false,
//         },
//         {
//           title: "Meeting",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-08-12",
//           className: "fc-bg-lightgreen",
//           icon: "suitcase",
//         },
//         {
//           title: "Conference",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-08-13",
//           end: "2019-08-15",
//           className: "fc-bg-blue",
//           icon: "calendar",
//         },
//         {
//           title: "Baby Shower",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-08-13",
//           end: "2019-08-14",
//           className: "fc-bg-default",
//           icon: "child",
//         },
//         {
//           title: "Birthday",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-09-13",
//           end: "2019-09-14",
//           className: "fc-bg-default",
//           icon: "birthday-cake",
//         },
//         {
//           title: "Restaurant",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-10-15T09:30:00",
//           end: "2019-10-15T11:45:00",
//           className: "fc-bg-default",
//           icon: "glass",
//           allDay: false,
//         },
//         {
//           title: "Dinner",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-11-15T20:00:00",
//           end: "2019-11-15T22:30:00",
//           className: "fc-bg-default",
//           icon: "cutlery",
//           allDay: false,
//         },
//         {
//           title: "Shooting",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-08-25",
//           end: "2019-08-25",
//           className: "fc-bg-blue",
//           icon: "camera",
//         },
//         {
//           title: "Go Space :)",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-12-27",
//           end: "2019-12-27",
//           className: "fc-bg-default",
//           icon: "rocket",
//         },
//         {
//           title: "Dentist",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2019-12-29T11:30:00",
//           end: "2019-12-29T012:30:00",
//           className: "fc-bg-blue",
//           icon: "medkit",
//           allDay: false,
//         },
//         {
//           title: "Dentist",
//           description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
//           start: "2020-06-27T11:30:00",
//           end: "2020-06-28T012:30:00",
//           className: "fc-bg-blue",
//           icon: "medkit",
//           allDay: false,
//         },
//       ],
//       eventRender: function (event, element) {
//         if (event.icon) {
//           element
//             .find(".fc-title")
//             .prepend("<i class='fa fa-" + event.icon + "'></i>");
//         }
//       },
//       select: function (start, end) {
//         $.getScript("/events/new", function () {
//           $("#datetimepicker7").datetimepicker();
//           $("#datetimepicker8").datetimepicker({
//             useCurrent: true,
//             format: true,
//             defaultDate: true,
//           });
//           $("#datetimepicker7").on("change.datetimepicker", function (e, start, end) {
//             $("#datetimepicker8").datetimepicker("start", e.date);
//             $(".start_hidden").val(moment(start).format("YYYY-MM-DD HH:mm"));
//           });
//           $("#datetimepicker8").on("change.datetimepicker", function (e) {
//             $("#datetimepicker7").datetimepicker("end", e.date);
//             $(".end_hidden").val(moment(end).format("YYYY-MM-DD HH:mm"));
//           });
//         });

//         calendar.fullCalendar("unselect");
//       },

//       eventClick: function (event, jsEvent, view) {
//         jQuery(".event-icon").html("<i class='fa fa-" + event.icon + "'></i>");
//         jQuery(".event-title").html(event.title);
//         jQuery(".event-body").html(event.description);
//         jQuery(".eventUrl").attr("href", event.url);
//         jQuery("#modal-view-event").modal();
//       },
//     });
//   });

//   $(document).ready(function () {
//     var select = function (start, end, allDay) {
//       var title = window.prompt("title");
//       var data = {
//         event: {
//           title: title,
//           start: start.format(),
//           end: end.format(),
//           allDay: allDay,
//         },
//       };
//       $.ajax({
//         type: "POST",
//         url: "/events",
//         data: data,

//         success: function () {
//           calendar.fullCalendar("refetchEvents");
//         },
//       });
//       calendar.fullCalendar("unselect");
//     };

//   });
// });
