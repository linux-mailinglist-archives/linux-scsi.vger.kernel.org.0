Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AA4388C0
	for <lists+linux-scsi@lfdr.de>; Sun, 24 Oct 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJXL7M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Oct 2021 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhJXL7M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 24 Oct 2021 07:59:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65018C061764
        for <linux-scsi@vger.kernel.org>; Sun, 24 Oct 2021 04:56:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a16so5981730wrh.12
        for <linux-scsi@vger.kernel.org>; Sun, 24 Oct 2021 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=rOs1jeHgvUVegfcp7fPDuZh8Osv3RGpuzqr0N/T9FHA=;
        b=Bf22S2O8VOb8X58WG4xVGysvEkLYgeYRTGCrYXRPrbnYXxAY4hY7BX0EyUIcQnEQTF
         m1R4R49gvdUcLjze9cz50+JSd2zS+ECRPS8+9ITlH4dX7OVAqIA0wgt2aeUZPgS69HA2
         xzZGvhUZjf8OH8J4uFlMfI/xGelOaIHvOpvvmLhMGAFbyQSc3FOZ5q82M+wjxK+Akloj
         WNwtzpBnsLe1jD950V+PJSjByZOh6AK/eG/+pgxnGIJ1I1cbHFJb8ce5qROaBVkE8C78
         Ll3GWPOeOsu+XtDepyNYNC6bwyj8YDTkz7UewS9qU4RkUPQI8QbUZiIb10+5OXXf8Tad
         eERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=rOs1jeHgvUVegfcp7fPDuZh8Osv3RGpuzqr0N/T9FHA=;
        b=oYw0Sbm4VmRe7BA8zv7FriKVE64ClwdW7UWS277rXRQK21eiIgISuDCITuGCd+nDLz
         QdPKrW6obVzQtORs/3zT5M8y12NNqwMkjUCpNd7IgHThVndAhEdBXFbuxscjuWm8LyWw
         3m01aWfZoT/J8RsmkUC4jYdWrl/IzhIDxHbvPRYzH0nGwF1W6k3PABiyxtEzpK+PtWrb
         JaDRmOy/vBiwxUVquQQ6+7clLZ4OhQniiFG0OFaaYso0g/qePo5lnvIcSRLprd9I/Niz
         gNHRJMawDjTQKAf5U/pEZW09egOPxrVdIaJTi4a9z06hoIwWCUEL5u/Mywa5JWvd+fXs
         rbHw==
X-Gm-Message-State: AOAM532RoMP6g1KHpSIdNaUxEwP3WXBEJ38XxvDf+/sOreHZiYjYefDA
        9qN7Oz3Ag7iFpNQPwMKnSERa85beo2RK2YVcW0w=
X-Google-Smtp-Source: ABdhPJz7daKxB5fTha37CympQ5aRMShlMn8PG2W5f2SV9COSHRqyieEJ5GuAEGN0HN0f+U/AwPV8inZ+f0MyRb1TcsE=
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr14898741wrd.16.1635076609487;
 Sun, 24 Oct 2021 04:56:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:670a:0:0:0:0:0 with HTTP; Sun, 24 Oct 2021 04:56:48
 -0700 (PDT)
Reply-To: martins.devatta@yandex.com
In-Reply-To: <CAERnzNWRFAbzK7O==quyLNc=x1me5eoE4UAaUaQK_J8cZ9Dh_w@mail.gmail.com>
References: <CAERnzNXE0obo7AxwEPripMv3Ab3Me4TUF2j4Jf5vgmSneNxJRQ@mail.gmail.com>
 <CAERnzNWGe18heN7+MAnimeJgnqSH0+AaftwF00sDPgRRvYRysQ@mail.gmail.com>
 <CAERnzNX6JCR=eNxnzrHRTmMfw9yid3jrhra2ParJbGPszfPRdA@mail.gmail.com>
 <CAERnzNXt-FC+zPhuV3OUu-=FwqTitue3tF+-b0OJH2T+HCjnzw@mail.gmail.com>
 <CAERnzNXrdc4BgOJ1PEdU9FEKC-ARpzSneRWWQmFwwfikLyZvFg@mail.gmail.com>
 <CAERnzNUH9qaDJNVMH9z5CuHVx8jzUxTiZiEO7NeEyMsjoLw2pQ@mail.gmail.com>
 <CAERnzNXztkhXYVGM6t-7h70qLdm+6h6n03EGF0E5+jpQDSA8KQ@mail.gmail.com>
 <CAERnzNUXf93yWyy7=udCQ_1araBJ-zLHC0ULgSEekfH2e8T2Cw@mail.gmail.com>
 <CAERnzNXt9yDYpOOZBFn_1dP0kVsomvZJFXipQuAKmX3pUVGrTQ@mail.gmail.com>
 <CAERnzNUS1zUoSDScnY--FWzTnx6etQo9NX0WdVAvBfKkU+tBew@mail.gmail.com>
 <CAERnzNU1=CnXxhZ+my5ruqHYSeznqtoHUOB1MNxxbkxEOoLd3w@mail.gmail.com>
 <CAERnzNWX+5XV=5ySRdvLKfzEyik82tO+mZ81zvqeMZeFYu+Bqg@mail.gmail.com>
 <CAERnzNU1_SBTwWgLagiGh33Q4oS0LFUoKF6Ax_NRrDv5uXYzCQ@mail.gmail.com>
 <CAERnzNWF2kEwY_Geq-snd1ERozzKaN_guRtrwfqqMTFiGwgr-w@mail.gmail.com>
 <CAERnzNV8AWwuVgP0vGSa+b6WA3G3tn+f81BwB-A7ur3FRD2mxg@mail.gmail.com>
 <CAERnzNX82WTgCBbY5cLrvMSnCHh6sAEtSmn3K0=Wt0tL=D=FdQ@mail.gmail.com>
 <CAERnzNUuGOtuwc=hZ+pCCDF8Pv5GF08VkHSuJrWt5Z9sEYXawg@mail.gmail.com>
 <CAERnzNW_HLgqxvEyqBJGa4TBirveq1sGmwWTUVw5q=WLOqS_OQ@mail.gmail.com>
 <CAERnzNWH6GFtLdvYa2_0Fk7hMdrQGwviW0v0R5Ws1k08S3qw7w@mail.gmail.com>
 <CAERnzNW-J4krf6DC0y9rApaJTddhS-P_A-FOUeE1pRMtamT_HA@mail.gmail.com>
 <CAERnzNXLHNwAQ4wGaMqLr6H0tAfzoQ_kRptvhLmYApXr_tOOuw@mail.gmail.com>
 <CAERnzNX3Chk2PtnSwurzLu41pkqhmEj6O00qvT=aRKz3yygd3A@mail.gmail.com>
 <CAERnzNUvo-+Si3BFNidp2w4g2mvY3BpAOfgDOK25ik2tDUJ0qA@mail.gmail.com>
 <CAERnzNVxEsKBi2p5XRFxxWPMiyWL+usBb4=bVoz-dnK4gzFiog@mail.gmail.com>
 <CAERnzNVq95n6k107Mvm358c0MBvVghcoJ4L0vSoSz0r5xmw7DA@mail.gmail.com>
 <CAERnzNXqx0S3Adz3VHYuLkD8dTmRx8z5F1MdKS22yc8sosHHFw@mail.gmail.com>
 <CAERnzNWYuA39RzN-3ij7hDgt2+Y8WRRKggYYk_D9LD1Z-zsiOA@mail.gmail.com>
 <CAERnzNXwXHH8CTpiUOR82knrNzYQW1033XJp6AyTihX+MLO7tw@mail.gmail.com>
 <CAERnzNX4yDJekjaX2iE-gfoVaZwL+sEgB+roYZ61xbKn3HPi3g@mail.gmail.com>
 <CAERnzNUVgzDuY5n+h5Ta_sK16t4620AxJVc9ANQ7ST5CGTqdyQ@mail.gmail.com>
 <CAERnzNXCdiifw6X_x1ZYn-ww_jmDddeQA9xMV27BFWAMFzy+Eg@mail.gmail.com>
 <CAERnzNVkcnRRKd8vCTdTzyeMLZ7N9i02=+CF8hF=AzKv_O7BfA@mail.gmail.com>
 <CAERnzNV3XVAvMnJZag9e7HyDr+EDADKW+kA2QTJ2RbqpMvr2OQ@mail.gmail.com>
 <CAERnzNVXyGKQLFxyXkWa9RnXdKozpVXba-ZC67HsSfXf4bhTcQ@mail.gmail.com>
 <CAERnzNU-tV-kok8wk9yFJt-mQh9qcGMQ2SE+zd7aDF=_QPWBSg@mail.gmail.com>
 <CAERnzNWqmi+z2YYuvJ8x2Fq+WqvOUScifYQ=010hjxkgrbQzMQ@mail.gmail.com>
 <CAERnzNUohdnORF96XD=E2VQBCSJSz4oueKdgWZ4JyyNJVv5RpA@mail.gmail.com>
 <CAERnzNXK5Wk0hemUkEe+-AzrVYQTi6K5UAOcwO6tdqbgiKFFog@mail.gmail.com>
 <CAERnzNVyKtD-FMJb-w4TRVdca8_Vmc0vs+wZmmA7dbxHmOCRpw@mail.gmail.com>
 <CAERnzNWeH764E_Ck8utFUNK07wzCvjqOk4q-a+_SA4VRsOYV4g@mail.gmail.com>
 <CAERnzNUthXi+gt_L+6-71vQsDBfh32aFWGy6wYsA6+X67SR5hQ@mail.gmail.com>
 <CAERnzNWkc9OHpr69SanvcF1Fs9ii=H5K7qC0G1qVKuBpK=Bpnw@mail.gmail.com>
 <CAERnzNVZj3r1xsdXx7iNUV8uvOSO9+59Xf7ap1bVJVKMzrp15g@mail.gmail.com>
 <CAERnzNVLGgoCBS6OgbNq=VvkQ9OHY46=xP20+apU2h_5n9d8uQ@mail.gmail.com>
 <CAERnzNUa=g13=v8_J4RyCuSE+DHf2wLAMjEF80-SDF_9GT2jwA@mail.gmail.com>
 <CAERnzNVYEU8ziWLOx6wAF62rhQssEEKFtMaKRXYLamGKbWeLwg@mail.gmail.com>
 <CAERnzNW=qbgSuKbH2yEfoiRGTy=WecY4sk9m=0XHtJpnE6AGRQ@mail.gmail.com>
 <CAERnzNWBb3sMLBOZkwewgiQZX16Otga9_7Xtd6+UafScNWFezA@mail.gmail.com>
 <CAERnzNUM1qY9VtPrd-p0WTh_vBqw8CwxxRwptbsShdLMSVZHEA@mail.gmail.com>
 <CAERnzNWemb=s-7efwE6sm=8GORf8hHYoUWKd321W1wGw4RpGXg@mail.gmail.com>
 <CAERnzNXJhUKnWHpw59J4+wPrUTnA_1NDHB3wakj+T2iPMJRfRA@mail.gmail.com>
 <CAERnzNWN8gojktc4p2mWf4v0dwh4OQMJSk0gNx1CWG16xKLJqQ@mail.gmail.com>
 <CAERnzNUnTErxuhMs=EoqQsQA-=N8te0qgbxochnW_K6VWEmGag@mail.gmail.com>
 <CAERnzNXS8QnuZrQ_-Vt4d7zyFrDULgED7d_M2_g4_63NMdhFog@mail.gmail.com>
 <CAERnzNUj2kRSBoDR2ABjX8xwQNDx6Z=FM+qoh==4iYpRhSnKbQ@mail.gmail.com>
 <CAERnzNUWCjn5ZGdeWcRTOXqoh54OsArF_Wg3tGAuQkFx8XaXmQ@mail.gmail.com>
 <CAERnzNUWUwFqVxdeq-MfejPDc18_kxJbsnzkWiFNbHDpDSa4pQ@mail.gmail.com>
 <CAERnzNWPEDBUrCfBGDex7xkpfFCt+d-6bWXk2UQ+rCm0US=2rg@mail.gmail.com>
 <CAERnzNVMXHnvxEc7TApO+LC2YbegqYAOt8b4H5dhbzET_8m0hA@mail.gmail.com>
 <CAERnzNX9Y9pm+G_RKAHuAmSmrKj01Dw9jxGGFkHtEKT3vcCJCQ@mail.gmail.com>
 <CAERnzNUMWXYm4kng8WXyr7hZmZ3RY0N0APTb_tNx2gnPiwpj=Q@mail.gmail.com>
 <CAERnzNXw9nkhhLNreAKAcKqNd9KOzW-jP_dzguKk+x5Ku2Emmg@mail.gmail.com>
 <CAERnzNUCtoh+UTOvYUfdf2MxrC36=E=_KcmWXjobYwaJX+tRXA@mail.gmail.com>
 <CAERnzNXM2LqN3WcyEjec0vfzKePYA6LxqFeNc63KEaOUc5=8pA@mail.gmail.com>
 <CAERnzNVSf93f-Cc4z=hfsz9xRsY_REZXhoigqhwzr4V_ejkVPQ@mail.gmail.com>
 <CAERnzNXp=DSf7q=KUViGuaF_b_Snrs-Rvk9dXZ9gJvDk2tmA-A@mail.gmail.com>
 <CAERnzNVXuo9_f_Ay6hQWkdjvygvqFg-=1yDBE1UX8irpr+Sgcg@mail.gmail.com>
 <CAERnzNVQCUZO3QQ4J2J1cRGpg3cE8ELBSuaQOK8B566eCGh=FA@mail.gmail.com>
 <CAERnzNWuJ8-7aLY1WpsEDLOoC6iPATb_GWzjAr4Jva2v5xfqEw@mail.gmail.com>
 <CAERnzNVoTWBdLNJjXdbsp7FUjeErCmT2fH+c_4dETkzVZ-FBtA@mail.gmail.com>
 <CAERnzNVpvm3zbEUCsADVUTgtLT19dD3s=ap_gg6gt9zindmdxw@mail.gmail.com>
 <CAERnzNU2nUQdUfwWgOPGab7ht1FE-xZetFD2db8Ry=SJ-o5YAg@mail.gmail.com>
 <CAERnzNUvfVutdTCZ6R9HVencigXkxapFZ17iamoDEmGsR_e2Ww@mail.gmail.com>
 <CAERnzNUTCZ6tW5a5y70MyGyNR3GeYAQ4ta5ZvBzpV-v3+CSctg@mail.gmail.com>
 <CAERnzNVdkrOwxtX3Kt37oCo=S7P7xgh6zs1gc2=hu53nY_VkPQ@mail.gmail.com>
 <CAERnzNV30__im_0AFD8Oju5OBWPrM=StNg-d3pW3Q8=uq+61aQ@mail.gmail.com>
 <CAERnzNWOVTtzjux_XYcoWTKzLRKPwwO1xd4x06cgky82qt1HBg@mail.gmail.com>
 <CAERnzNW9z0iSCt3bP5EDDsoLsNquWjRLcdumw1KRCoPeM+-Agg@mail.gmail.com>
 <CAERnzNVuzmmhbvZBty9B9KcMqBchdYZ1FAjs-ehdU=U6iPV-SA@mail.gmail.com>
 <CAERnzNWgEa0qsjjcNVz+-DrBd9=SAcTJOEDyAo6F1ZpOwf7jJg@mail.gmail.com>
 <CAERnzNUO-e0wS4SdW2neRj2zPDoiKYuVE2jKNrVCUEPGYnD8-w@mail.gmail.com>
 <CAERnzNV=yS7um62NTHfx-K=V=nvAzrXW88thzrhUmJuOS1s8nQ@mail.gmail.com>
 <CAERnzNUTHE2K5rh0H=-6Uhz5YE+8PfT3zU0O62td9tVtQsbSNw@mail.gmail.com>
 <CAERnzNWJJ7wm_EydsHqX4gu_56iAsN7kXWv-VCo+51QSfPAN5w@mail.gmail.com>
 <CAERnzNUw+rLX4QoYYD7e_Mk=MQfAkQtb8UH0j-vFD6ifBALqdA@mail.gmail.com>
 <CAERnzNW03OLBSDDpyp0ACn4rSFudbLqB3wGF=N3+pU6kyU+wNg@mail.gmail.com>
 <CAERnzNUU6EmgZp1d3FW0HhTP4KDujnmytHfSErxDmi2Z2UCRbQ@mail.gmail.com>
 <CAERnzNVTSvPXsQL8zwiVY8FywGcOxr4zCz4-bx-HLV4Nx3rVxQ@mail.gmail.com>
 <CAERnzNUuyLrsnf_VLmpLupx53Y2TcR9f0Qx_F7rsHL=y13y6yw@mail.gmail.com>
 <CAERnzNU_x6Y8He5vA5dXD4eO8SQbwUNmf9myNLwtRu9N-zthWA@mail.gmail.com>
 <CAERnzNWzGtm3gJ+=8hDjCbgs=z_pR3NRK7c+JKNPQvurBfuDYQ@mail.gmail.com>
 <CAERnzNXTGJ=EpvzwfSRLNxr0m3N2SmKLGqnvg1wQ2m_mYw-Bfg@mail.gmail.com>
 <CAERnzNXkW8UOnyyZ4q+tXyd2iqdLzGwhxOvjApM-Py=_dF700Q@mail.gmail.com>
 <CAERnzNXSApfVgx_DMokb+nh_cWLtzD5RcojuMGTgZWNP8p0NNg@mail.gmail.com>
 <CAERnzNVOsr+Ptt0ov001BUXsXU16OZcxNCe7d+t6Y0oiJ1ASbw@mail.gmail.com>
 <CAERnzNWNFvkmArYMnLvH4pf76_WAXNL8YLhEedhkHJ70q2fr_A@mail.gmail.com>
 <CAERnzNXmCZUDgZFLfsnaELKzxUeqYd2zF3CTc855=AsPH1oqwg@mail.gmail.com>
 <CAERnzNU8nRo39P3gdLZttVMghkpHusbJHPUZPYRvKh+Uv9rqRg@mail.gmail.com>
 <CAERnzNUYVLhANRXz4Er0Eso=37ZsfA0nK4Vp41jJL+Nk+PBniQ@mail.gmail.com> <CAERnzNWRFAbzK7O==quyLNc=x1me5eoE4UAaUaQK_J8cZ9Dh_w@mail.gmail.com>
From:   martin devatta <cassar99hormond@gmail.com>
Date:   Sun, 24 Oct 2021 13:56:48 +0200
Message-ID: <CAERnzNWM6+odt0pWYKFAKyK8kgmi3ASOufnkseuT+hnvZ_L09A@mail.gmail.com>
Subject: From Procurement Supervisor
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Sir,

I greet you with warm regards. I work for Malaysia Oil Refinery Sdn
Bhd Company as a procurement supervisor, Malaysia Oil Refinery Sdn Bhd
is an Oil Refining Company located in South East Asia.

On my desk is a mandate to arrange for a Crude Oil purchase from the
National Oil Corporation of Libya, from the State of Libya for up to
2,000,000 (2 Million) barrels on monthly bases for 12 calendar months.

The reason for my reaching out to you is because I am in the process
of establishing a broker / mediator or a middle man structure to
mediate between the 2 parties involved (our Company and the Company in
Libya) before the contract is signed.

You may be wondering why I cannot execute this transaction by myself.
The honest fact is that as an employee working for this company, it is
against our company operational ethics / policy for an employee to be
involved or profit in any financial dealings involving our Company,
hence I am looking for a trustworthy person outside my work circle in
order to maintain a discreet profile.

I wish to extend this partnership to your friend to build a broker /
mediator or a middle man structure with you while I work from the
background to guide you. Our company pays between $ 2 - $ 3 per barrel
of Crude Oil as a commission / brokerage amount, if the target of 2
Million barrels is a monthly we stand to share $ 4 Million - $ 6
Million every month for a span of 12 months .

Contact me if you are interested in this deal, so that I can give you
further details.

Martin  Devatta
Procurement Supervisor
Crude Oil & ProductsTrading Division
Malaysia Oil Refinery Sdn Bhd
Tel: +60 11 1722 5155
E-mail:martins.oil@yandex.com
