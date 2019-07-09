Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475BC63D32
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfGIVSr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 17:18:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35446 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfGIVSq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 17:18:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so300728wrm.2
        for <linux-scsi@vger.kernel.org>; Tue, 09 Jul 2019 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7s/zM6i2BZKPxi/o0Sg1+9dwKda6tTVMYz5XTx5xkRA=;
        b=BAmScHptk0d2/dVLGtA2OJO9v0BPC04WRQXz4tFDfc7TLl3KS7lJEK76NMY5uvBjEW
         PNmNSlm+svughIb6fPfL3maMkbMCkCEZKUa+RElVNGzLqfriX5x0Z0XwekRZhL+aE8y5
         pXAq+GfEPZzhgBybQSj0Dbu2KQ3lRIlgLwCep+Acrf5J6UmppToQymMyH0+q6xiKQB4J
         KkNZv9yFlRpmumEEuzMcUFA8781SZmMz8Rl21E/N0YYGQyUTmXDHbWPRG4af5FFKRrsm
         F+qzvQn9cfBu+dg9dhyqoPrR1fiwxq4vAJfXnwf0eXy9/LPOskXckE9xK6Y0Y/MJ0d65
         W6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7s/zM6i2BZKPxi/o0Sg1+9dwKda6tTVMYz5XTx5xkRA=;
        b=lxABZ6HD9Gm7KXgQsl/GeyK66FGRmbbgWCEXWCT601fUW98ZkmahbV3EZjtx69ZJhW
         KlFmr1RkxRXp29tyB7S8j3dDxLGM6ktajffxHAC7oFrh24U18A26qZH5LCtn+tsLxMS3
         ZdpmMpyeLcl1HPEtI9dfFZ+KU5xMeSjHcx5o7Nv2tqMgdeO3lJaFwAxD6A6mUbQYiENc
         4rRsHYfLqeOF1S6hxrrRqY83U2IHWZUG4CPbi6TDXOeIIizMSKm8gc/+/UUM/UJYM4Ev
         iqZ42GdjAFuIMNGqADicbAPnsiywILiswGe6WgWifmNc8ONn4hTy9vhShqrUc53RST9V
         povA==
X-Gm-Message-State: APjAAAW4Jug0uFg+9O8Ezr1LoN8IUFEcSdAwv4xy9Th+fBtaeJpLij3C
        PzZuM/PIIu5RvHy1RKM8ewMatg==
X-Google-Smtp-Source: APXvYqw7wWPJ/ZpQKsP/UnhBsQIYaBMsCew8Tugmde0WFoSn0oocKVlzTzUTdmyBKkT/+PTvGbVSQQ==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr14893268wrx.175.1562707123547;
        Tue, 09 Jul 2019 14:18:43 -0700 (PDT)
Received: from brian.unipv.it ([5.170.172.27])
        by smtp.gmail.com with ESMTPSA id y2sm43600wrl.4.2019.07.09.14.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:18:42 -0700 (PDT)
Date:   Tue, 9 Jul 2019 23:18:38 +0200
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20190709211838.GA9645@brian.unipv.it>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702120112.GA19890@ming.t460p>
 <20190702223931.GB3735@brian.unipv.it>
 <20190703020119.GA23872@ming.t460p>
 <20190703051117.GA6458@brian.unipv.it>
 <20190703063603.GA32123@ming.t460p>
 <20190706093327.GA31927@brian.unipv.it>
 <20190708010134.GA7248@ming.t460p>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20190708010134.GA7248@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 08/07/19 09:01:35, Ming Lei wrote:
> > > > > > > > 
> > > > > > > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > > > > > > 
> > > > > > > >  [...]    
> 
> 1) run the bcc biosnoop trace in one terminal after mounting the fs on the USB dirve
> 
> 2) start the write test in another teminal
> 
> 3) wait for 10 seconds, and stop the bcc trace via ctrl^ + C, then post the bcc biosnoop
> trace log
>

Done, attached.

Thanks,
Andrea

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="biosnoop_sdf.txt"

5.420198000    jbd2/sdf1-8    6775   sdf     W  29624320  4096       0.37
5.423601000    jbd2/sdf1-8    6775   sdf     W  29624328  12288      3.29
5.424009000    jbd2/sdf1-8    6775   sdf     W  29624352  4096       0.30
6.665732000    kworker/u8:0   6401   sdf     R  10248     4096     841.64
6.666891000    kworker/u8:0   6401   sdf     R  10256     4096       0.98
6.668141000    kworker/u8:0   6401   sdf     R  4196352   4096       1.07
6.669312000    kworker/u8:0   6401   sdf     R  8390656   4096       0.99
6.670568000    kworker/u8:0   6401   sdf     R  12584960  4096       1.06
6.674257000    kworker/u8:0   6401   sdf     R  16779264  4096       3.50
6.675510000    kworker/u8:0   6401   sdf     R  20973568  4096       1.06
6.678344000    kworker/u8:0   6401   sdf     R  25167872  4096       2.64
6.680384000    kworker/u8:0   6401   sdf     R  29362176  4096       1.83
6.681622000    kworker/u8:0   6401   sdf     R  33556480  4096       1.03
6.682713000    kworker/u8:0   6401   sdf     R  37750784  4096       0.92
6.686360000    kworker/u8:0   6401   sdf     R  41945088  4096       3.48
6.687589000    kworker/u8:0   6401   sdf     R  46139392  4096       1.04
6.688639000    kworker/u8:0   6401   sdf     R  46139424  4096       0.88
6.766336000    kworker/u8:0   6401   sdf     W  47351808  122880    77.17
6.773563000    kworker/u8:0   6401   sdf     W  47352048  122880     7.08
6.780980000    kworker/u8:0   6401   sdf     W  47352288  122880     7.29
6.786366000    kworker/u8:0   6401   sdf     W  47352528  122880     5.27
6.793831000    kworker/u8:0   6401   sdf     W  47352768  122880     7.38
6.801085000    kworker/u8:0   6401   sdf     W  47353008  122880     7.20
6.808405000    kworker/u8:0   6401   sdf     W  47353248  122880     7.27
6.813799000    kworker/u8:0   6401   sdf     W  47353488  122880     5.35
6.821103000    kworker/u8:0   6401   sdf     W  47353728  118784     7.25
6.828459000    kworker/u8:0   6401   sdf     W  47353960  122880     7.09
6.835722000    kworker/u8:0   6401   sdf     W  47354200  122880     7.20
6.842813000    kworker/u8:0   6401   sdf     W  47354440  122880     7.05
6.850184000    kworker/u8:0   6401   sdf     W  47354680  122880     7.32
6.857452000    kworker/u8:0   6401   sdf     W  47354920  122880     7.22
6.864874000    kworker/u8:0   6401   sdf     W  47355160  122880     7.38
6.871841000    kworker/u8:0   6401   sdf     W  47355400  122880     6.92
6.879380000    kworker/u8:0   6401   sdf     W  47355640  122880     7.50
6.886497000    kworker/u8:0   6401   sdf     W  47355880  122880     7.04
6.893940000    kworker/u8:0   6401   sdf     W  47356120  122880     7.40
6.899304000    kworker/u8:0   6401   sdf     W  47356360  122880     5.33
6.906635000    kworker/u8:0   6401   sdf     W  47356600  122880     7.29
6.913957000    kworker/u8:0   6401   sdf     W  47356840  122880     7.29
6.921308000    kworker/u8:0   6401   sdf     W  47357080  122880     7.31
6.924391000    kworker/u8:0   6401   sdf     W  47357320  53248      3.03
6.931971000    kworker/u8:0   6401   sdf     W  47357424  122880     7.22
6.939169000    kworker/u8:0   6401   sdf     W  47357664  122880     7.14
6.944985000    kworker/u8:0   6401   sdf     W  47357904  122880     5.76
6.952113000    kworker/u8:0   6401   sdf     W  47358144  122880     7.06
6.959608000    kworker/u8:0   6401   sdf     W  47358384  122880     7.45
6.966820000    kworker/u8:0   6401   sdf     W  47358624  122880     7.16
6.972393000    kworker/u8:0   6401   sdf     W  47358864  122880     5.53
6.979550000    kworker/u8:0   6401   sdf     W  47359104  122880     7.09
6.986879000    kworker/u8:0   6401   sdf     W  47359344  122880     7.28
6.994306000    kworker/u8:0   6401   sdf     W  47359584  122880     7.40
7.001338000    kworker/u8:0   6401   sdf     W  47359824  122880     6.98
7.008740000    kworker/u8:0   6401   sdf     W  47360064  122880     7.37
7.016114000    kworker/u8:0   6401   sdf     W  47360304  122880     7.31
7.023546000    kworker/u8:0   6401   sdf     W  47360544  122880     7.39
7.030437000    kworker/u8:0   6401   sdf     W  47360784  122880     6.82
7.037834000    kworker/u8:0   6401   sdf     W  47361024  122880     7.35
7.045224000    kworker/u8:0   6401   sdf     W  47361264  122880     7.32
7.052687000    kworker/u8:0   6401   sdf     W  47361504  122880     7.39
7.057977000    kworker/u8:0   6401   sdf     W  47361744  122880     5.01
7.065390000    kworker/u8:0   6401   sdf     W  47361984  122880     7.35
7.072749000    kworker/u8:0   6401   sdf     W  47362224  122880     7.28
7.080174000    kworker/u8:0   6401   sdf     W  47362464  122880     7.36
7.085335000    kworker/u8:0   6401   sdf     W  47362704  122880     5.08
7.092881000    kworker/u8:0   6401   sdf     W  47362944  122880     7.50
7.100197000    kworker/u8:0   6401   sdf     W  47363184  122880     7.23
7.107507000    kworker/u8:0   6401   sdf     W  47363424  122880     7.24
7.114684000    kworker/u8:0   6401   sdf     W  47363664  122880     7.09
7.121936000    kworker/u8:0   6401   sdf     W  47363904  122880     7.18
7.129299000    kworker/u8:0   6401   sdf     W  47364144  122880     7.29
7.136645000    kworker/u8:0   6401   sdf     W  47364384  122880     7.27
7.143733000    kworker/u8:0   6401   sdf     W  47364624  122880     7.02
7.151112000    kworker/u8:0   6401   sdf     W  47364864  122880     7.31
7.158509000    kworker/u8:0   6401   sdf     W  47365104  122880     7.33
7.165735000    kworker/u8:0   6401   sdf     W  47365344  122880     7.14
7.171205000    kworker/u8:0   6401   sdf     W  47365584  122880     5.40
7.178625000    kworker/u8:0   6401   sdf     W  47365824  122880     7.37
7.185980000    kworker/u8:0   6401   sdf     W  47366064  122880     7.31
7.193593000    kworker/u8:0   6401   sdf     W  47366304  122880     7.57
7.198674000    kworker/u8:0   6401   sdf     W  47366544  122880     5.02
7.205996000    kworker/u8:0   6401   sdf     W  47366784  122880     7.25
7.213419000    kworker/u8:0   6401   sdf     W  47367024  122880     7.37
7.221005000    kworker/u8:0   6401   sdf     W  47367264  122880     7.52
7.227906000    kworker/u8:0   6401   sdf     W  47367504  122880     6.83
7.235251000    kworker/u8:0   6401   sdf     W  47367744  122880     7.28
7.241892000    kworker/u8:0   6401   sdf     W  47367984  106496     6.59
7.249617000    kworker/u8:0   6401   sdf     W  47368192  122880     6.88
7.256892000    kworker/u8:0   6401   sdf     W  47368432  122880     7.20
7.264223000    kworker/u8:0   6401   sdf     W  47368672  122880     7.26
7.269672000    kworker/u8:0   6401   sdf     W  47368912  122880     5.39
7.277066000    kworker/u8:0   6401   sdf     W  47369152  122880     7.36
7.284630000    kworker/u8:0   6401   sdf     W  47369392  122880     7.52
7.291891000    kworker/u8:0   6401   sdf     W  47369632  122880     7.20
7.297211000    kworker/u8:0   6401   sdf     W  47369872  122880     5.29
7.304665000    kworker/u8:0   6401   sdf     W  47370112  122880     7.41
7.312050000    kworker/u8:0   6401   sdf     W  47370352  122880     7.33
7.319520000    kworker/u8:0   6401   sdf     W  47370592  122880     7.41
7.326494000    kworker/u8:0   6401   sdf     W  47370832  122880     6.89
7.334082000    kworker/u8:0   6401   sdf     W  47371072  122880     7.52
7.341505000    kworker/u8:0   6401   sdf     W  47371312  122880     7.34
7.348600000    kworker/u8:0   6401   sdf     W  47371552  122880     7.01
7.355806000    kworker/u8:0   6401   sdf     W  47371792  122880     7.16
7.363147000    kworker/u8:0   6401   sdf     W  47372032  122880     7.27
7.370377000    kworker/u8:0   6401   sdf     W  47372272  122880     7.16
7.377770000    kworker/u8:0   6401   sdf     W  47372512  122880     7.36
7.383323000    kworker/u8:0   6401   sdf     W  47372752  122880     5.50
7.390651000    kworker/u8:0   6401   sdf     W  47372992  122880     7.27
7.398245000    kworker/u8:0   6401   sdf     W  47373232  122880     7.52
7.405347000    kworker/u8:0   6401   sdf     W  47373472  122880     7.04
7.410761000    kworker/u8:0   6401   sdf     W  47373712  122880     5.36
7.418075000    kworker/u8:0   6401   sdf     W  47373952  122880     7.26
7.425451000    kworker/u8:0   6401   sdf     W  47374192  122880     7.33
7.432864000    kworker/u8:0   6401   sdf     W  47374432  122880     7.36
7.439913000    kworker/u8:0   6401   sdf     W  47374672  122880     6.99
7.447312000    kworker/u8:0   6401   sdf     W  47374912  122880     7.35
7.454721000    kworker/u8:0   6401   sdf     W  47375152  122880     7.35
7.461955000    kworker/u8:0   6401   sdf     W  47375392  122880     7.19
7.469040000    kworker/u8:0   6401   sdf     W  47375632  122880     7.04
7.476416000    kworker/u8:0   6401   sdf     W  47375872  122880     7.31
7.483856000    kworker/u8:0   6401   sdf     W  47376112  122880     7.38
7.491270000    kworker/u8:0   6401   sdf     W  47376352  122880     7.37
7.496452000    kworker/u8:0   6401   sdf     W  47376592  122880     5.12
7.504011000    kworker/u8:0   6401   sdf     W  47376832  122880     7.52
7.511217000    kworker/u8:0   6401   sdf     W  47377072  122880     7.12
7.518511000    kworker/u8:0   6401   sdf     W  47377312  122880     7.23
7.523956000    kworker/u8:0   6401   sdf     W  47377552  122880     5.41
7.531197000    kworker/u8:0   6401   sdf     W  47377792  122880     7.21
7.538546000    kworker/u8:0   6401   sdf     W  47378032  122880     7.31
7.545757000    kworker/u8:0   6401   sdf     W  47378272  122880     7.17
7.552919000    kworker/u8:0   6401   sdf     W  47378512  122880     7.13
7.560269000    kworker/u8:0   6401   sdf     W  47378752  122880     7.31
7.567555000    kworker/u8:0   6401   sdf     W  47378992  122880     7.25
7.574863000    kworker/u8:0   6401   sdf     W  47379232  122880     7.27
7.581802000    kworker/u8:0   6401   sdf     W  47379472  122880     6.87
7.588979000    kworker/u8:0   6401   sdf     W  47379712  122880     7.13
7.596343000    kworker/u8:0   6401   sdf     W  47379952  122880     7.30
7.603224000    kworker/u8:0   6401   sdf     W  47380192  122880     6.84
7.608655000    kworker/u8:0   6401   sdf     W  47380432  122880     5.38
7.615811000    kworker/u8:0   6401   sdf     W  47380672  122880     7.12
7.623028000    kworker/u8:0   6401   sdf     W  47380912  122880     7.18
7.630413000    kworker/u8:0   6401   sdf     W  47381152  122880     7.34
7.635223000    kworker/u8:0   6401   sdf     W  47381392  122880     4.75
7.642268000    kworker/u8:0   6401   sdf     W  47381632  122880     6.98
7.649383000    kworker/u8:0   6401   sdf     W  47381872  122880     7.04
7.656619000    kworker/u8:0   6401   sdf     W  47382112  122880     7.19
7.661918000    kworker/u8:0   6401   sdf     W  47382352  122880     5.25
8.268039000    kworker/u8:0   6401   sdf     W  47382592  122880   606.07
8.280414000    kworker/u8:0   6401   sdf     W  47382832  122880    12.30
8.286503000    kworker/u8:0   6401   sdf     W  47383072  122880     6.02
8.293627000    kworker/u8:0   6401   sdf     W  47383312  122880     7.07
8.300777000    kworker/u8:0   6401   sdf     W  47383552  122880     7.08
8.307733000    kworker/u8:0   6401   sdf     W  47383792  122880     6.89
8.315212000    kworker/u8:0   6401   sdf     W  47384032  122880     7.43
8.320697000    kworker/u8:0   6401   sdf     W  47384272  122880     5.41
8.323335000    kworker/u8:0   6401   sdf     W  47384512  32768      2.58
8.331116000    kworker/u8:0   6401   sdf     W  47384576  122880     6.58
8.338586000    kworker/u8:0   6401   sdf     W  47384816  122880     7.40
8.346113000    kworker/u8:0   6401   sdf     W  47385056  122880     7.46
8.351558000    kworker/u8:0   6401   sdf     W  47385296  122880     5.37
8.359030000    kworker/u8:0   6401   sdf     W  47385536  122880     7.43
8.366425000    kworker/u8:0   6401   sdf     W  47385776  122880     7.34
8.373712000    kworker/u8:0   6401   sdf     W  47386016  122880     7.22
8.940689000    cp             6828   sdf     W  47400960  122880   566.92
9.614647000    kworker/u8:0   6401   sdf     W  47386256  122880   673.87
10.179120000   cp             6828   sdf     W  47401200  122880   564.38

--M9NhX3UHpAaciwkO--
