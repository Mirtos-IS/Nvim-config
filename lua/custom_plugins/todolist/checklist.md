instant_payment_received.cta
property_manager_profile.property
buttons.set_up_payout_account

email_cleaner.performance_bonus_email_cleaner.recieved.subject
email_cleaner.performance_bonus_email_cleaner.recieved.preheader
email_cleaner.performance_bonus_email_cleaner.recieved.title
email_cleaner.performance_bonus_email_cleaner.recieved.body
email_cleaner.performance_bonus_email_cleaner.recieved.review_date
email_cleaner.performance_bonus_email_cleaner.recieved.cleanliness_tags
email_cleaner.performance_bonus_email_cleaner.recieved.guest_message

email_cleaner.performance_bonus_email_cleaner.no_stripe.subject
email_cleaner.performance_bonus_email_cleaner.no_stripe.body_1
email_cleaner.performance_bonus_email_cleaner.no_stripe.body_2

email_cleaner.performance_bonus_email_cleaner.payout_sent.preheader
email_cleaner.performance_bonus_email_cleaner.payout_sent.bonus_tag
email_cleaner.performance_bonus_notifications_cleaner.payout_scheduled
email_cleaner.performance_bonus_notifications.bonus_recieved.title
email_cleaner.performance_bonus_notifications.bonus_recieved.body
email_cleaner.performance_bonus_notifications.set_account_bonus.body

server: https://israel.turno.dev/
Admin credentials: admin@turnoverbnb.com / 1234567890

```php
<?php
$project = App\Models\Project::first()
$contractor = App\Models\Contractor::first()
$log = App\Models\PaymentLog::first()
App\Models\Contractor::first()->user->notify(new App\Notifications\PerformanceBonusReceivedNotification())
resolve(App\Libraries\Payments\InstantPayoutManager::class)->enableInstantPayoutFeature($user->contractor);

Route::get('/test/email', function () {
    return (new SomeEmailClass)->toMail(App\Models\User::first());
});

