function doResize() {
  var iw = $("img#streamimage").width();
  var ww = $(window).width() * 0.8;

  if ( ww < 600 ) {
    $("img#streamimage").width( ww );
  } else {
    $("img#streamimage").width( 600 );
  }
  $("img#streamimage").height(  $("img#streamimage").width() * 0.75 );

  if ( ww < 300 ) {
    $("table#buttontable td").width( ww / 3 );
  } else {
    $("table#buttontable td").width( 100 );
  }
  $("table#buttontable td").height( $("table#buttontable td").width() );
}

$(window).load(function() {
  doResize();
  $(window).on('resize', doResize);
});


webiopi().ready(function() {

  var left, right, top, button;

  top = $( "#topbuttons" );
  left = $( "#leftbuttons" );
  right = $( "#rightbuttons" );

  webiopi().setFunction(11, "OUT"); // mode
  webiopi().setValue(11, 0);	  // IN-IN mode
  webiopi().setFunction(9, "PWM");  // a phase
  webiopi().setFunction(10, "PWM"); // a enable
  webiopi().setFunction(21, "PWM"); // b phase
  webiopi().setFunction(22, "PWM"); // b enable

  // Note that on iDevices, touchstart/touchend come first and
  // mousedown/mouseup are also fired, so you have to disable
  // them from within touchstart/touchend

  $("#F").bind("mousedown", fwd);
  $("#F").bind("mouseup", stop);
  $("#F").bind("touchstart", function() {
    fwd();
    $(this).unbind("mousedown");
  });
  $("#F").bind("touchend", function() {
    stop();
    $(this).unbind("mousedown");
  });

  $("#R").bind("mousedown", rev);
  $("#R").bind("mouseup", stop);
  $("#R").bind("touchstart", function() {
    rev();
    $(this).unbind("mousedown");
  });
  $("#R").bind("touchend", function() {
    stop();
    $(this).unbind("mouseup");
  });

  $("#SR").bind("mousedown", spinRight);
  $("#SR").bind("touchstart", function() {
    spinRight();
    $(this).unbind("mousedown");
  });
  $("#SR").bind("mouseup", stop);
  $("#SR").bind("touchend", function() {
    stop();
    $(this).unbind("mouseup");
  });

  $("#SL").bind("mousedown", spinLeft);
  $("#SL").bind("mouseup", stop);
  $("#SL").bind("touchstart", function() {
    spinLeft();
    $(this).unbind("mousedown");
  });
  $("#SL").bind("touchend", function() {
    stop();
    $(this).unbind("mouseup");
  });

  $("#ST").bind("mouseup", stop);
  $("#ST").bind("touchstart mousedown", stop);

  $("#ST").bind("touchstart mousedown", function() {
    stop();
    $(this).unbind("mousedown");
  });
  $("#ST").bind("touchend", function() {
    stop();
    $(this).unbind("mouseup");
  });

});

function sign(x) {
  return x / Math.abs(x);
}


	function fwd() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 0);     // AIN1
                webiopi().pulseRatio(10, 0.7);  // AIN2
                webiopi().pulseRatio(21, 0);    // BIN1
                webiopi().pulseRatio(22, 0.5);  // BIN2
	}

	function fwdLeft() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 1.0);	// AIN1
                webiopi().pulseRatio(10, 1.0);	// AIN2
                webiopi().pulseRatio(21, 0);	// BIN1
                webiopi().pulseRatio(22, 1.0);	// BIN2
	}

	function fwdRight() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 0);	// AIN1
                webiopi().pulseRatio(10, 1.0);	// AIN2
                webiopi().pulseRatio(21, 1.0);	// BIN1
                webiopi().pulseRatio(22, 1.0);	// BIN2
	}

	function rev() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 0.6);	// AIN1
                webiopi().pulseRatio(10, 0);	// AIN2
                webiopi().pulseRatio(21, 0.6);	// BIN1
                webiopi().pulseRatio(22, 0);	// BIN2
	}

	function revRight() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 1.0);	// AIN1
                webiopi().pulseRatio(10, 1.0);	// AIN2
                webiopi().pulseRatio(21, 0.6);	// BIN1
                webiopi().pulseRatio(22, 0);	// BIN2
	}

	function revLeft() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 0.6);	// AIN1
                webiopi().pulseRatio(10, 0);	// AIN2
                webiopi().pulseRatio(21, 1.0);	// BIN1
                webiopi().pulseRatio(22, 1.0);	// BIN2
	}

	function spinLeft() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 0.6);	// AIN1
                webiopi().pulseRatio(10, 0);	// AIN2
                webiopi().pulseRatio(21, 0);	// BIN1
                webiopi().pulseRatio(22, 0.6);	// BIN2
	}

	function spinRight() {
		webiopi().setValue(11, 0);
		webiopi().pulseRatio(9, 0.0);	// AIN2
		webiopi().pulseRatio(10, 0.6);	// AIN2
		webiopi().pulseRatio(21, 0.6);	// BIN2
		webiopi().pulseRatio(22, 0);	// BIN2
	}

	function stop() {
                webiopi().setValue(11, 0);
                webiopi().pulseRatio(9, 1.0);	// AIN1
                webiopi().pulseRatio(10, 1.0);	// AIN2
                webiopi().pulseRatio(21, 1.0);	// BIN1
                webiopi().pulseRatio(22, 1.0);	// BIN2
	}



