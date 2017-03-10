/* global Stripe */

// Document ready - turbolinks can sometimes interfere with jQuery, so need to
// do this modified version
$(document).on('turbolinks:load', function () {
  // Target form and submit button using jQuery
  const form = $('#pro_form');
  const submitBtn = $('#form-signup-btn');

  // Set Stripe public key
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

  // When user clicks the form submit button, prevent default submission behavior
  submitBtn.click(function (evt) {
    evt.preventDefault();
    submitBtn.val("Processing").prop('disabled', true);

    // Collect the credit card fields
    const ccNum = $('#card_number').val();
    const cvcNum = $('#card_code').val();
    const expMonth = $('#card_month').val();
    const expYear = $('#card_year').val();

    // Use Strip JS library to check for card errors
    let error = false;

    // Validate card number
    if (!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('The credit card number appears to be invalid.');
    }

    // Validate CVC number
    if (!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('The CVC number appears to be invalid.');
    }

    // Validate expiration date
    if (!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The expiration date appears to be invalid.');
    }

    if (error) {
      // Don't send to Stripe and re-enable button
      submitBtn.val("Sign up").prop('disabled', false);
    } else {
      // Send the card info to Stripe
      // stripeResponseHandler will be whatever we want to happen when Stripe
      // sends us the card token back
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    // Exit out of function
    return false;
  });

  // Stripe will return a card token
  function stripeResponseHandler (status, response) {
    const token = response.id;
    // Inject card token as hidden field into form & submit form to our Rails app
    form.append($('<input type="hidden" name="user[stripe_card_token]">').val(token));
    form.get(0).submit();
  }
});
