// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('.vin-lookup').on('submit', function(event){
 	event.preventDefault();
 	vinLookup();
  });
});

var vinLookup = function (){
	var new_vin = $('input[name="vin"]').val();

	$.ajax({
		url: "https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVINValuesBatch/",
		type: "POST",
		data: { format: "json", data: new_vin},
		dataType: "json",
		success: function(result){
			var car = {vin: new_vin, year: result.Results[0].ModelYear, make: result.Results[0].Make,
					   model: result.Results[0].Model, engine: result.Results[0].EngineCylinders}
			$("#car_vin").val(new_vin)
			$("#car_year").val(result.Results[0].ModelYear)
			$("#car_make").val(result.Results[0].Make)
			$("#car_model").val(result.Results[0].Model)
			$("#car_engine").val(result.Results[0].EngineCylinders + " Cylinder")
		},
		error: function(xhr, ajaxOptions, thrownError){
		console.log(xhr.status);
		console.log(thrownError);
		}
	});
}