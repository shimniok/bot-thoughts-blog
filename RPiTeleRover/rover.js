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

  function iUnbind() {
    $("#F").unbind("mousedown mouseup mouseenter mouseleave");
    $("#R").unbind("mousedown mouseup mouseenter mouseleave");
    $("#SL").unbind("mousedown mouseup mouseenter mouseleave");
    $("#SR").unbind("mousedown mouseup mouseenter mouseleave");
    $("#S").unbind("mousedown mouseup mouseenter mouseleave");
  }


  // Disable double-click text highlighting
  $(function() {
    $.extend($.fn.disableTextSelect = function() {
      return this.each(function() {
        if($.browser.mozilla) {//Firefox
          $(this).css('MozUserSelect','none');
        } else if($.browser.msie) {//IE
          $(this).bind('selectstart',function(){return false;});
        } else {//Opera, etc.
          $(this).mousedown(function(){return false;});
        }
      });
    });
    $('.button').disableTextSelect();//No text selection on elements with a class of 'button'
  });

  $("#F").bind("touchstart mousedown", fwd);
  $("#F").bind("mouseup", stop);
  $("#F").bind("touchend", function() {
    stop();
    iUnbind();
  });

  $("#R").bind("touchstart mousedown", rev);
  $("#R").bind("mouseup", stop);
  $("#R").bind("touchend", function() {
    stop();
    iUnbind();
  });

  $("#SR").bind("touchstart mousedown", spinRight);
  $("#SR").bind("mouseup", stop);
  $("#SR").bind("touchend", function() {
    stop();
    iUnbind();
  });

  $("#SL").bind("touchstart mousedown", spinLeft);
  $("#SL").bind("mouseup", stop);
  $("#SL").bind("touchend", function() {
    stop();
    iUnbind();
  });

  $("#ST").bind("touchstart mousedown", stop);
  $("#ST").bind("mouseup", stop);
  $("#ST").bind("touchend", function() {
    stop();
    iUnbind();
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



