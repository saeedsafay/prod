<?php

$config['events_actions_name'] = 'handle';
/**
 *
 * 'event.constant.name' => [
 *      'module' => [
 *           'ListenerClass',
 *      ]
 * ]
 */
$config['events'] = [
    'cart.item.added' => [
        'shop' => [
            'AddItemToCartListener',
        ],
    ],
    'session.cart.item.added' => [
        'shop' => [
            'AddItemToSessionCartListener',
        ],
    ],
    'product.is.viewed' => [
        'shop' =>
            [
                'AddProductViewCountListener',
                'UpdateCookieListener',
            ],
    ],
    'payment.created' => [
        'payment' =>
            [
                'AddNewPaymentTransactionListener',
            ],
    ],
    'payment.failed' => [
        'payment' =>
            [
                'UpdateFailedPaymentTransactionListener',
            ],
        'monitor' =>
            [
                'SendTelegramFailedPaymentListener',
                'SendSlackFailedPaymentListener',
            ]
    ],
    'payment.success' => [
        'payment' =>
            [
                'VerifyPaymentListener',
            ],
        'shop' =>
            [
                'VerifyOrderListener',
            ]
    ],
    'order.placed' => [
        'shop' =>
            [
                'SendUserOrderEmailListener',
                'SendUserOrderSMSListener',
                'SendSupportOrderEmailListener',
                'UpdateQuantityListener',
            ],
        'monitor' =>
            [
                'SendTelegramOrderListener',
                'SendSlackOrderListener',
            ]
    ],
    'user.logged.in' => [
        'shop' => [
            'PortSessionCartToDatabaseCartListener'
        ]
    ],
    'newsletter.member.added' => [
        'users' => [
            'SendVerificationEmailListener'
        ]
    ],
    'user.registered' => [
        'monitor' =>
            [
                'SendTelegramNewRegisterListener',
                'SendSlackNewRegisterListener',
            ],
        'users' =>
            [
//                'SendDiscountCouponListener',
            ]
    ],
];