define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json');


    function construct() {

        //  province data
        this.province = {"":"لطفا استان خود را انتخاب نمایید", "آذربايجان شرقي":"آذربايجان شرقي", "آذربايجان غربي":"آذربايجان غربي", "اردبيل":"اردبيل", "اصفهان":"اصفهان", "البرز":"البرز",
            "ايلام":"ايلام", "بوشهر":"بوشهر", "تهران":"تهران", "چهارمحال بختياري":"چهارمحال بختياري", "خراسان جنوبي":"خراسان جنوبي", "خراسان رضوي":"خراسان رضوي",
            "خراسان شمالي":"خراسان شمالي", "خوزستان":"خوزستان", "زنجان":"زنجان", "سمنان":"سمنان", "سيستان و بلوچستان":"سيستان و بلوچستان", "فارس":"فارس", "قزوين":"قزوين", "قم":"قم",
            "كردستان":"كردستان", "كرمان":"كرمان", "كرمانشاه":"كرمانشاه", "كهكيلويه و بويراحمد":"كهكيلويه و بويراحمد", "گلستان":"گلستان", "گيلان":"گيلان", "لرستان":"لرستان",
            "مازندران":"مازندران", "مركزي":"مركزي", "هرمزگان":"هرمزگان", "همدان":"همدان", "يزد":"يزد"};
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_event: function () {},

        load_province_values: function (item) {
            let select_values = this.province;

            //  remove all previous province options
            item.find('option').remove();

            //  set foreach city values
            this.insert_value_options(select_values, item);
        },

        //  load city values into html select
        load_city_values: function (province, item) {
            let  select_values = {};

            //  remove all previous city options
            item.find('option').remove();

            switch (province) {
                case "آذربايجان شرقي":
                    select_values = {"آذر شهر":"آذر شهر","اسكو":"اسكو","اهر":"اهر","بستان آباد":"بستان آباد","بناب":"بناب","بندر شرفخانه":"بندر شرفخانه","تبريز":"تبريز","تسوج":"تسوج","جلفا":"جلفا","سراب":"سراب","شبستر":"شبستر","صوفيان":"صوفيان","عجبشير":"عجبشير","قره آغاج":"قره آغاج","كليبر":"كليبر","كندوان":"كندوان","مراغه":"مراغه","مرند":"مرند","ملكان":"ملكان","ممقان":"ممقان","ميانه":"ميانه","هاديشهر":"هاديشهر","هريس":"هريس","هشترود":"هشترود","ورزقان":"ورزقان"};
                    break;
                case "آذربايجان غربي":
                    select_values = {"اروميه":"اروميه","اشنويه":"اشنويه","بازرگان":"بازرگان","بوكان":"بوكان","پلدشت":"پلدشت","پيرانشهر":"پيرانشهر","تكاب":"تكاب","خوي":"خوي","سردشت":"سردشت","سلماس":"سلماس","سيه چشمه- چالدران":"سيه چشمه- چالدران","سيمينه":"سيمينه","شاهين دژ":"شاهين دژ","شوط":"شوط","ماكو":"ماكو","مهاباد":"مهاباد","مياندوآب":"مياندوآب","نقده":"نقده"};
                    break;
                case "اردبيل":
                    select_values = {"اردبيل":"اردبيل","بيله سوار":"بيله سوار","پارس آباد":"پارس آباد","خلخال":"خلخال","سرعين":"سرعين","كيوي (كوثر)":"كيوي (كوثر)","گرمي (مغان)":"گرمي (مغان)","مشگين شهر":"مشگين شهر","مغان (سمنان)":"مغان (سمنان)","نمين":"نمين","نير":"نير"};
                    break;
                case "اصفهان":
                    select_values = {"آران و بيدگل":"آران و بيدگل","اردستان":"اردستان","اصفهان":"اصفهان","باغ بهادران":"باغ بهادران","تيران":"تيران","خميني شهر":"خميني شهر","خوانسار":"خوانسار","دهاقان":"دهاقان","دولت آباد-اصفهان":"دولت آباد-اصفهان","زرين شهر":"زرين شهر","زيباشهر (محمديه)":"زيباشهر (محمديه)","سميرم":"سميرم","شاهين شهر":"شاهين شهر","شهرضا":"شهرضا","فريدن":"فريدن","فريدون شهر":"فريدون شهر","فلاورجان":"فلاورجان","فولاد شهر":"فولاد شهر","قهدريجان":"قهدريجان","كاشان":"كاشان","گلپايگان":"گلپايگان","گلدشت اصفهان":"گلدشت اصفهان","گلدشت مركزي":"گلدشت مركزي","مباركه اصفهان":"مباركه اصفهان","مهاباد-اصفهان":"مهاباد-اصفهان","نايين":"نايين","نجف آباد":"نجف آباد","نطنز":"نطنز","هرند":"هرند"};
                    break;
                case "البرز":
                    select_values = {"آسارا":"آسارا","اشتهارد":"اشتهارد","شهر جديد هشتگرد":"شهر جديد هشتگرد","طالقان":"طالقان","كرج":"كرج","گلستان تهران":"گلستان تهران","نظرآباد":"نظرآباد","هشتگرد":"هشتگرد"};
                    break;
                case "ايلام":
                    select_values = {"آبدانان":"آبدانان","ايلام":"ايلام","ايوان":"ايوان","دره شهر":"دره شهر","دهلران":"دهلران","سرابله":"سرابله","شيروان چرداول":"شيروان چرداول","مهران":"مهران"};
                    break;
                case "بوشهر":
                    select_values = {"آبپخش":"آبپخش","اهرم":"اهرم","برازجان":"برازجان","بندر دير":"بندر دير","بندر ديلم":"بندر ديلم","بندر كنگان":"بندر كنگان","بندر گناوه":"بندر گناوه","بوشهر":"بوشهر","تنگستان":"تنگستان","جزيره خارك":"جزيره خارك","جم (ولايت)":"جم (ولايت)","خورموج":"خورموج","دشتستان - شبانکاره":"دشتستان - شبانکاره","دلوار":"دلوار","عسلويه":"عسلويه"};
                    break;
                case "تهران":
                    select_values = {"آبسرد": "آبسرد","آبعلی": "آبعلی","ارجمند": "ارجمند","اسلامشهر": "اسلامشهر","اندیشه": "اندیشه","باغستان": "باغستان","باقرشهر": "باقرشهر","بومهن": "بومهن","پا کدشت": "پاکدشت","پردیس": "پردیس","پیشوا": "پیشوا","تهران": "تهران","جواد آباد": "جواد آباد","چهاردانگه": "چهاردانگه","حسن آباد": "حسن آباد","دماوند": "دماوند","رباط کریم": "رباط کریم","رودهن": "رودهن","ری": "ری","شاهدشهر": "شاهدشهر","شریف آباد": "شریف آباد","شمشک": "شمشک","شهر جدید پرند": "شهر جدید پرند","شهریار": "شهریار","صالحیه": "صالحیه","صبا شهر": "صبا شهر","صفادشت": "صفادشت","فردوسیه": "فردوسیه","فرون آباد": "فرون آباد","فشم": "فشم","فیروزکوه": "فیروزکوه","قدس": "قدس","قرچک": "قرچک","کهریزک": "کهریزک","کیلان": "کیلان","گلستان": "گلستان","لواسان": "لواسان","ملارد": "ملارد","نسیم شهر": "نسیم شهر","نصیرشهر": "نصیرشهر","وحیدیه": "وحیدیه", "ورامین": "ورامین"};
                    break;
                case "چهارمحال بختياري":
                    select_values = {"اردل":"اردل","بروجن":"بروجن","چلگرد (كوهرنگ)":"چلگرد (كوهرنگ)","سامان":"سامان","شهركرد":"شهركرد","فارسان":"فارسان","لردگان":"لردگان"};
                    break;
                case "خراسان جنوبي":
                    select_values = {"بشرويه":"بشرويه","بيرجند":"بيرجند","خضري":"خضري","خوسف":"خوسف","سرايان":"سرايان","سربيشه":"سربيشه","طبس":"طبس","فردوس":"فردوس","قائن":"قائن","نهبندان":"نهبندان"};
                    break;
                case "خراسان رضوي":
                    select_values = {"بجستان":"بجستان","بردسكن":"بردسكن","تايباد":"تايباد","تربت جام":"تربت جام","تربت حيدريه":"تربت حيدريه","جغتاي":"جغتاي","جوين":"جوين","چناران":"چناران","خليل آباد":"خليل آباد","خواف":"خواف","درگز":"درگز","رشتخوار":"رشتخوار","سبزوار":"سبزوار","سرخس":"سرخس","طبس":"طبس","طرقبه":"طرقبه","فريمان":"فريمان","قوچان":"قوچان","كاشمر":"كاشمر","كلات":"كلات","گناباد":"گناباد","مشهد":"مشهد","نيشابور":"نيشابور"};
                    break;
                case "خراسان شمالي":
                    select_values = {"آشخانه، مانه و سمرقان":"آشخانه، مانه و سمرقان","اسفراين":"اسفراين","بجنورد":"بجنورد","جاجرم":"جاجرم","شيروان":"شيروان","فاروج":"فاروج"};
                    break;
                case "خوزستان":
                    select_values = {"آبادان":"آبادان","اميديه":"اميديه","انديمشك":"انديمشك","اهواز":"اهواز","ايذه":"ايذه","باغ ملك":"باغ ملك","بستان":"بستان","بندر ماهشهر":"بندر ماهشهر","بندرامام خميني":"بندرامام خميني","بهبهان":"بهبهان","خرمشهر":"خرمشهر","دزفول":"دزفول","رامشير":"رامشير","رامهرمز":"رامهرمز","سوسنگرد":"سوسنگرد","شادگان":"شادگان","شوش":"شوش","شوشتر":"شوشتر","لالي":"لالي","مسجد سليمان":"مسجد سليمان","هنديجان":"هنديجان","هويزه":"هويزه"};
                    break;
                case "زنجان":
                    select_values = {"آب بر (طارم)":"آب بر (طارم)","ابهر":"ابهر","خرمدره":"خرمدره","زرين آباد (ايجرود)":"زرين آباد (ايجرود)","زنجان":"زنجان","قيدار (خدا بنده)":"قيدار (خدا بنده)","ماهنشان":"ماهنشان"};
                    break;
                case "سمنان":
                    select_values = {"ايوانكي":"ايوانكي","بسطام":"بسطام","دامغان":"دامغان","سرخه":"سرخه","سمنان":"سمنان","شاهرود":"شاهرود","شهميرزاد":"شهميرزاد","گرمسار":"گرمسار","مهديشهر":"مهديشهر"};
                    break;
                case "سيستان و بلوچستان":
                    select_values = {"ايرانشهر":"ايرانشهر","چابهار":"چابهار","خاش":"خاش","راسك":"راسك","زابل":"زابل","زاهدان":"زاهدان","سراوان":"سراوان","سرباز":"سرباز","ميرجاوه":"ميرجاوه","نيكشهر":"نيكشهر"};
                    break;
                case "فارس":
                    select_values = {"آباده":"آباده","آباده طشك":"آباده طشك","اردكان":"اردكان","ارسنجان":"ارسنجان","استهبان":"استهبان","اشكنان":"اشكنان","اقليد":"اقليد","اوز":"اوز","ايج":"ايج","ايزد خواست":"ايزد خواست","باب انار":"باب انار","بالاده":"بالاده","بنارويه":"بنارويه","بهمن":"بهمن","بوانات":"بوانات","بيرم":"بيرم","بيضا":"بيضا","جنت شهر":"جنت شهر","جهرم":"جهرم","حاجي آباد-زرين دشت":"حاجي آباد-زرين دشت","خاوران":"خاوران","خرامه":"خرامه","خشت":"خشت","خفر":"خفر","خنج":"خنج","خور":"خور","داراب":"داراب","رونيز عليا":"رونيز عليا","زاهدشهر":"زاهدشهر","زرقان":"زرقان","سده":"سده","سروستان":"سروستان","سعادت شهر":"سعادت شهر","سورمق":"سورمق","ششده":"ششده","شيراز":"شيراز","صغاد":"صغاد","صفاشهر":"صفاشهر","علاء مرودشت":"علاء مرودشت","عنبر":"عنبر","فراشبند":"فراشبند","فسا":"فسا","فيروز آباد":"فيروز آباد","قائميه":"قائميه","قادر آباد":"قادر آباد","قطب آباد":"قطب آباد","قير":"قير","كازرون":"كازرون","كنار تخته":"كنار تخته","گراش":"گراش","لار":"لار","لامرد":"لامرد","لپوئي":"لپوئي","لطيفي":"لطيفي","مبارك آباد ديز":"مبارك آباد ديز","مرودشت":"مرودشت","مشكان":"مشكان","مصير":"مصير","مهر فارس(گله دار)":"مهر فارس(گله دار)","ميمند":"ميمند","نوبندگان":"نوبندگان","نودان":"نودان","نورآباد":"نورآباد","ني ريز":"ني ريز","کوار":"کوار"};
                    break;
                case "قزوين":
                    select_values = {"آبيك":"آبيك","البرز":"البرز","بوئين زهرا":"بوئين زهرا","تاكستان":"تاكستان","قزوين":"قزوين","محمود آباد نمونه":"محمود آباد نمونه"};
                    break;
                case "قم":
                    select_values = {"قم":"قم"};
                    break;
                case "كردستان":
                    select_values = {"بانه":"بانه","بيجار":"بيجار","دهگلان":"دهگلان","ديواندره":"ديواندره","سقز":"سقز","سنندج":"سنندج","قروه":"قروه","كامياران":"كامياران","مريوان":"مريوان"};
                    break;
                case "كرمان":
                    select_values = {"بابك":"بابك","بافت":"بافت","بردسير":"بردسير","بم":"بم","جيرفت":"جيرفت","راور":"راور","رفسنجان":"رفسنجان","زرند":"زرند","سيرجان":"سيرجان","كرمان":"كرمان","كهنوج":"كهنوج","منوجان":"منوجان"};
                    break;
                case "كرمانشاه":
                    select_values = {"اسلام آباد غرب":"اسلام آباد غرب","پاوه":"پاوه","تازه آباد- ثلاث باباجاني":"تازه آباد- ثلاث باباجاني","جوانرود":"جوانرود","سر پل ذهاب":"سر پل ذهاب","سنقر كليائي":"سنقر كليائي","صحنه":"صحنه","قصر شيرين":"قصر شيرين","كرمانشاه":"كرمانشاه","كنگاور":"كنگاور","گيلان غرب":"گيلان غرب","هرسين":"هرسين"};
                    break;
                case "كهكيلويه و بويراحمد":
                    select_values = {"دهدشت":"دهدشت","دوگنبدان":"دوگنبدان","سي سخت- دنا":"سي سخت- دنا","گچساران":"گچساران","ياسوج":"ياسوج"};
                    break;
                case "گلستان":
                    select_values = {"آزاد شهر":"آزاد شهر","آق قلا":"آق قلا","انبارآلوم":"انبارآلوم","اينچه برون":"اينچه برون","بندر گز":"بندر گز","تركمن":"تركمن","جلين":"جلين","خان ببين":"خان ببين","راميان":"راميان","سرخس کلاته":"سرخس کلاته","سيمين شهر":"سيمين شهر","علي آباد كتول":"علي آباد كتول","فاضل آباد":"فاضل آباد","كردكوي":"كردكوي","كلاله":"كلاله","گاليکش":"گاليکش","گرگان":"گرگان","گميش تپه":"گميش تپه","گنبد كاووس":"گنبد كاووس","مراوه تپه":"مراوه تپه","مينو دشت":"مينو دشت","نگين شهر":"نگين شهر","نوده خاندوز":"نوده خاندوز","نوکنده":"نوکنده"};
                    break;
                case "گيلان":
                    select_values = {"آستارا":"آستارا","آستانه اشرفيه":"آستانه اشرفيه","املش":"املش","بندرانزلي":"بندرانزلي","خمام":"خمام","رشت":"رشت","رضوان شهر":"رضوان شهر","رود سر":"رود سر","رودبار":"رودبار","سياهكل":"سياهكل","شفت":"شفت","صومعه سرا":"صومعه سرا","فومن":"فومن","كلاچاي":"كلاچاي","لاهيجان":"لاهيجان","لنگرود":"لنگرود","لوشان":"لوشان","ماسال":"ماسال","ماسوله":"ماسوله","منجيل":"منجيل","هشتپر":"هشتپر"};
                    break;
                case "لرستان":
                    select_values = {"ازنا":"ازنا","الشتر":"الشتر","اليگودرز":"اليگودرز","بروجرد":"بروجرد","پلدختر":"پلدختر","خرم آباد":"خرم آباد","دورود":"دورود","سپيد دشت":"سپيد دشت","كوهدشت":"كوهدشت","نورآباد (خوزستان)":"نورآباد (خوزستان)"};
                    break;
                case "مازندران":
                    select_values = {"آمل":"آمل","بابل":"بابل","بابلسر":"بابلسر","بلده":"بلده","بهشهر":"بهشهر","پل سفيد":"پل سفيد","تنكابن":"تنكابن","جويبار":"جويبار","چالوس":"چالوس","خرم آباد":"خرم آباد","رامسر":"رامسر","رستم کلا":"رستم کلا","ساري":"ساري","سلمانشهر":"سلمانشهر","سواد كوه":"سواد كوه","فريدون كنار":"فريدون كنار","قائم شهر":"قائم شهر","گلوگاه":"گلوگاه","محمودآباد":"محمودآباد","مرزن آباد":"مرزن آباد","نكا":"نكا","نور":"نور","نوشهر":"نوشهر"};
                    break;
                case "مركزي":
                    select_values = {"آشتيان":"آشتيان","اراك":"اراك","تفرش":"تفرش","خمين":"خمين","دليجان":"دليجان","ساوه":"ساوه","شازند":"شازند","محلات":"محلات","کميجان":"کميجان"};
                    break;
                case "هرمزگان":
                    select_values = {"ابوموسي":"ابوموسي","انگهران":"انگهران","بستك":"بستك","بندر جاسك":"بندر جاسك","بندر لنگه":"بندر لنگه","بندرعباس":"بندرعباس","پارسيان":"پارسيان","حاجي آباد":"حاجي آباد","دشتي":"دشتي","دهبارز (رودان)":"دهبارز (رودان)","قشم":"قشم","كيش":"كيش","ميناب":"ميناب"};
                    break;
                case "همدان":
                    select_values = {"اسدآباد":"اسدآباد","بهار":"بهار","تويسركان":"تويسركان","رزن":"رزن","كبودر اهنگ":"كبودر اهنگ","ملاير":"ملاير","نهاوند":"نهاوند","همدان":"همدان"};
                    break;
                case "يزد":
                    select_values = {"ابركوه":"ابركوه","اردكان":"اردكان","اشكذر":"اشكذر","بافق":"بافق","تفت":"تفت","مهريز":"مهريز","ميبد":"ميبد","هرات":"هرات","يزد":"يزد"};
                    break;
                case "":
                    select_values = {"":"لطفا شهر خود را انتخاب نمایید"}

            }

            //  set foreach city values
            this.insert_value_options(select_values, item);
        },

        //  insert data options into select html
        insert_value_options: function (array, item) {

            //  set foreach option values
            obj_json.jquery_obj_each( this.update_city_options, array, [item] );
        },
        update_city_options: function (item, index, arg) {

            //  insert city's values into html
            arg[0].append($('<option></option>').attr('value', index).text(item));
        }



    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

