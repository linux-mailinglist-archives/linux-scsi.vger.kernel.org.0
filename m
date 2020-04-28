Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BB1BC548
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgD1QeR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Apr 2020 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgD1QeR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Apr 2020 12:34:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4AC03C1AB
        for <linux-scsi@vger.kernel.org>; Tue, 28 Apr 2020 09:34:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w6so21066075ilg.1
        for <linux-scsi@vger.kernel.org>; Tue, 28 Apr 2020 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=F+eAn2E/J+zNkM0ZtaMnhLdJDXKznalZV00lErNyU+Y=;
        b=klPlvfX7e/XdWvif0pd2k8jLHltAnM6leviwBqHLe6Erue8RCbwK6pVnDFfy4rV8+x
         NOjpp/ivbA70o/W/K8RyEiUP082brHF7qqnZN0VpC7zJtzNlvSgOGBy+EqFjwxH5EClU
         h0o58K5wYLBuQKBP10W2XZEpPrRLPd3vMoDw0+E39gQSnsutH0KJEi3F2hsqnd6huRRe
         xYj3dThs6WyoPOPdwAFY1BlIcgQunFIOhkGh+xET2TNUKsMw9u/PDK+3/5/4vfF/zPVV
         QPr2nrE0hSYPqCZzCUbVG38BEzZqpFu5bImwhLFG+Vbw43h/ltb3tWlH+KOvSoNCRvXe
         KsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=F+eAn2E/J+zNkM0ZtaMnhLdJDXKznalZV00lErNyU+Y=;
        b=TUVNQKRjYyxZv4BFcRZe+ZzoSdSU+a3vMOnjqiiR7yJSXVWU83gksSq4wcEinrM9lP
         Hz+UXy5Fe70q35g1O9PbpQbgfdVACeyrQ5tJ0MWXgjYBXH/MB7TJGzKXsMhAzbpOf0Ai
         o8dFKPYQnY4qYoBWAF+iZNKRH67EXfAfpvuM+YX6HOJmLjhyMUNc0c+igXoDd0epeh6/
         yT/9r9jOfj5Tt4dis5bdt9gc9WAuHk9WCnPvipc2/5CUSjnDCAWIWNibU4XKqmQU3loN
         fcsQeiV0rLi7gM91Xaoe/JLHq7p9Aba52dQYXYdCOWBXhs83JoA0gQ4Ks3Kfqr0WHXkE
         ZDIw==
X-Gm-Message-State: AGi0PuaH5iFC/2HTmBHgH9eNCV65iuc3PKYU/A17inbjbT/H7wc9PTEQ
        J8UljWUwhBwHUHMzR3oZoWSzU4txp8u0BSEsFhI=
X-Google-Smtp-Source: APiQypKaZysSo9DeL+rck7UIwjOKnHpkeoYe1Dp7U8voP+uTeRHDzSg6Wjk4T59UeDrZ0mUz8mz0JCJe+DOIiPq0Xew=
X-Received: by 2002:a92:c711:: with SMTP id a17mr28259790ilp.175.1588091656035;
 Tue, 28 Apr 2020 09:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:8592:0:0:0:0:0 with HTTP; Tue, 28 Apr 2020 09:34:14
 -0700 (PDT)
Reply-To: kennethjj51@yahoo.com
In-Reply-To: <CALuQghawzsC02hSt1LHORv1E223wp18R0KPAvU6D7V+nETpZVg@mail.gmail.com>
References: <CALuQghazuh7PCSk_pkwoj7has8tCtcpjK5PGSLY_VECB9a1P6g@mail.gmail.com>
 <CALuQghYa0qtCHZwX0xd4XzoCf9nVwwX32Y-56+4RxKCSB8Mo7Q@mail.gmail.com>
 <CALuQghbRCjSF6D2rMoN7k0Nin=TP+BMekiTkXcgEOswTx16cEQ@mail.gmail.com>
 <CALuQghaGv300aMYt=BxgKpfhUxJ=kQhFOfr1n49Ufv7ZsDh5AQ@mail.gmail.com>
 <CALuQghZY81jaT9h7F7g-LzC7YUgtfoJOHPTNiSR7-kjCHDvaoA@mail.gmail.com>
 <CALuQgha3hOqE+RFgMDOOfRnqHL59m-J8MyrK1v84rojSe7mVPg@mail.gmail.com>
 <CALuQghba8OcsjRWMQ4oOxa3Ag0rg=qV4=0K71TZJEKYTwniOOQ@mail.gmail.com>
 <CALuQgha7X4_Nz9TUrt7KB6X9nuV74h0nNR30b9JkzYzmZwZPGQ@mail.gmail.com>
 <CALuQghZo6sorTdxESBCEKcEkUUHa7eU07saGkT9tD_dnWyM3YQ@mail.gmail.com>
 <CALuQghZiJwcMeHGqonbXDWrQkXjQSdEZs=6XpXFZ-of51CgTbg@mail.gmail.com>
 <CALuQghacwJY6nkv7fRDD9zcQiERvDP7iSuLX9+5FrO5Ygyb4ng@mail.gmail.com>
 <CALuQghY+qoPA4-we58J+NuyWtiQYnhc1K7E=QDKukt6DXj93hg@mail.gmail.com>
 <CALuQghbCq=VXaDZkZ1zWgLihFmzkUp5+At0RQnLVqk_jQbVORw@mail.gmail.com>
 <CALuQghYKhhJ0WiaJk_ZZaz_ZuEZ5ATwr_P3iEBV2LZbUU4Wkig@mail.gmail.com>
 <CALuQghZ-vqQrPXv-uxe8SHaSUeT=O+Okfqyo56UUsAqy=NwyVA@mail.gmail.com>
 <CALuQghYePLtEOKbdsFCv+OyGYtcx6cR_WnrBXQ=W3MZtFpD31Q@mail.gmail.com>
 <CALuQghYM0cvTtMUphipMqEG2yYVaPY=F7y9X7_CmotRv1CxepQ@mail.gmail.com>
 <CALuQghbDYaRnTaG-G-DZ8k2wsUFnqTOfuXBj0NWS+GpaKvY0zw@mail.gmail.com>
 <CALuQghZPeytmz_3Mx7hbHRi0rvFSPsT30KKUW3jKrdApWtT91w@mail.gmail.com>
 <CALuQghbUi=+z=fiSNHbfxDWg=D2CW3tBysGwRsekekkHqCTvSA@mail.gmail.com>
 <CALuQghbT9ixmzQwQyY3sGvHqBbxQLi0tmRi-jTJPSPN5sf_-ng@mail.gmail.com>
 <CALuQghZ9xKUj_X9Q_WBQ0zCM2_Wjd1XZ5XhMz04JGbHbrwO8VQ@mail.gmail.com>
 <CALuQghYbuvgqDJoRyq1wwujC_LeSn7cwYjBorOZqEua90ZkObQ@mail.gmail.com>
 <CALuQghbWRAYM1PNgkUMWyxJERQpps+hPm4vVrtDf6MKbCvy7bg@mail.gmail.com>
 <CALuQghZ1zmtKS7Ye+QsAYpz2-ju5hNb=Kdfr7oXujHn6ja3rNw@mail.gmail.com>
 <CALuQghaZ+RvB+4yDfNtJUvPHiGKeqRs3hdk57sqbozhFhfPg6w@mail.gmail.com>
 <CALuQghawY4sgN+QtfRwUyPcQ=0RRzN7Mm+mq=Ai_HnzTG1+2NQ@mail.gmail.com>
 <CALuQghbdZYypHJv29nQMMGzCu0Wd0Jy78rVNjSdAD1Xr2rE9kQ@mail.gmail.com>
 <CALuQghazSZWxJ1V9U6R0Vf7gH2Jh3E+nTYGX1B-_9ZaM=P_3Zw@mail.gmail.com>
 <CALuQghZ4VSD=ssBcJNzGX+-xbE_nDAj0QcCSNz5C3aU=K=U2pg@mail.gmail.com>
 <CALuQghYD6jqoHxunviJYqOnCcMYVP9AS3pMYkp_WjyoLWG_91w@mail.gmail.com>
 <CALuQghaYanpmRtoUYC6U6D0pkT2yy_u8YuXPVSbLvv+p_VPDMg@mail.gmail.com>
 <CALuQghagNn8SWEThtpbCGPcNPDxv2hLE+1biyoLg1HFZrrrB8w@mail.gmail.com>
 <CALuQghZs2R7-v2Fv0yC-hA9map=pmPH9_qgqgZ0ztJjrsndfkQ@mail.gmail.com>
 <CALuQghZyHfNpr62dopkAy-6gr8oPdAudT9LmuzgUkc3EaDWxoA@mail.gmail.com>
 <CALuQghYe1_TE+9i1B9CEc2xo_GNFCupNiKtT_TNWayzGthG86w@mail.gmail.com>
 <CALuQghZhqxDDSJCO63LrzkcDNAiqxCwgh+92ikqr9Yy2-SNzvw@mail.gmail.com>
 <CALuQghZcZPymBXPKhP5FJdcJz1xwT8=nKGjsLsyDKQ6ip+WEEQ@mail.gmail.com>
 <CALuQghaHFfVYjdGPx9RfcgLcSXB5WNnYprgNd2GUzQ9qaEUi_Q@mail.gmail.com>
 <CALuQghYi1bk4wE+hkSU_7gZjQw2ekaARCULvQgmpU_c+Aiqajw@mail.gmail.com>
 <CALuQghb-kWb+EWjN-tO_O=4tmgLLY4Jp8-k2u4H6o5EN8L8N1w@mail.gmail.com>
 <CALuQghae0n+z-+KRLU_ipu28GeHz9M8DYKRyoPK2K_biN-6LRA@mail.gmail.com>
 <CALuQghZv2FuLWF3ctqFF6dgnpUFvkfDYrkE6bqdNC6KLuJAyYQ@mail.gmail.com>
 <CALuQghZOXMJ2=JACh-XH+EiabeVeeDObf_roNpdqmW=rhFR=Hg@mail.gmail.com>
 <CALuQghazcCDvTnn6QgZ_or_4BBCaK87zm6e3ong_iFBt26V-qA@mail.gmail.com>
 <CALuQghZmSTT90QnfdqgXx69qMFdzK+Bmh9-17oOjjN0naiY_mQ@mail.gmail.com>
 <CALuQghYwq2cowSRk4TYbWC8bXt9RvXn0w=tb64CCof1whfT9mQ@mail.gmail.com>
 <CALuQghYt6UqgS+67k-opwk36uFNvf7kpDwUv6EMXc-+n7kBHeQ@mail.gmail.com>
 <CALuQghYiFszaohwkoR=NLzkcaoBBd+JJz06RV2yTP_ZLVApAfg@mail.gmail.com>
 <CALuQghYG4p_O8jzd_TCnqvC8AsE9rwHzO6oqjuEeCquc7sp97w@mail.gmail.com>
 <CALuQghauV2C0y2cvS_4QWi0=E+wXDMfvenc7xyPU8j1Xn4BA5Q@mail.gmail.com>
 <CALuQghbCaYbY+hA-s6GnbHHoysZ5+VrDhk1UXWjWFCnpFY1d=g@mail.gmail.com>
 <CALuQghYsJwVrFrr6+xCAv5AnxS8tTXrwg2EnVD7kbJUxow6rcw@mail.gmail.com>
 <CALuQghb2xNHksuVeuTZK9cHoC+Luvb_egDc+3VOxZ6egxd1M3A@mail.gmail.com>
 <CALuQghYO02=KHBPFYyhx9tBgnGduv0ux8qwF5uiZYvfaYqcHXA@mail.gmail.com>
 <CALuQghZrs-09C7D2kGY_YDRC4vA76XbwBLcLO+N8qV9B-YoR5g@mail.gmail.com>
 <CALuQghaKbXJRN5YuRO--bDAPzbDJgRBLAQD6U+vm1Ef7gCQMPA@mail.gmail.com>
 <CALuQghbAkHsRH_wnbN4Ettz8y6e2t6+kmPp0n=QuX9cAYzYTcQ@mail.gmail.com>
 <CALuQghYWKfnSqikd_jvGEes2HAaGezxr78WGUMkN2z7s=nAF0Q@mail.gmail.com>
 <CALuQghb0xNxfqACYH775gLwUgsik4Ok725MuZ7gnENFmGSrZGw@mail.gmail.com>
 <CALuQghZaTFdFU6YCJZjKUCZf8TDKV+sm2B0K645KN42sFBCr0g@mail.gmail.com>
 <CALuQgharynmnp8=SKbU9N1WTzBXtYuw66MDMbjxmtq3XF736qw@mail.gmail.com>
 <CALuQghYNM-KRMn4DcYhAGQ8gsLAutPjMNiNX+FwwEGW_uK2Ymw@mail.gmail.com>
 <CALuQghYTM128Fg+-aP4huTk4_FeJ3XshS5rc4WMrH6JjaKbqGQ@mail.gmail.com>
 <CALuQghaqCfA_s1AYkr3cS5j2yqRG+r+Y9PX4skutPvJWngs1SA@mail.gmail.com>
 <CALuQghaK62SBU_kodH69bxhS-2o-vFwtS-_k=Tjs25P4Q2-LtQ@mail.gmail.com>
 <CALuQgha1go-vbCEDn4HVyjrzV3VPUJ7ZVHc6by++ZFCDsOmqhg@mail.gmail.com>
 <CALuQghZk3_sKoDtxFsdek=aRO=MAHUYkG9vDE0omAd5VeJHBMA@mail.gmail.com>
 <CALuQghbOQtBQosUNZ3yxUBFfiart7hFL558Ab0qeu8Z6MLuzsA@mail.gmail.com>
 <CALuQghYNaTBvD9XXLsAO18pnW7e5Qj2cnFNa5wj-A9J+yL9hEA@mail.gmail.com>
 <CALuQghavHi38jALNCk2SOVe_8Dv9oPbTj-mPOkoxkfX5M69RMg@mail.gmail.com>
 <CALuQghZAmu1qTu75mCv9HjQb2_SuQNdwQVzNTAVNQSWL_zgoMw@mail.gmail.com>
 <CALuQghboHR1zRcw-WxBevmcNY8E9OL=M=ds08RVey9X9OVO6Ug@mail.gmail.com>
 <CALuQgha2438H2nDHJ=qjT9CU-X8xUPrFnc3ywp1C5OHPPL8Hsg@mail.gmail.com>
 <CALuQgha8X2Fa_y9YHN_Lo3sE-WyNN20qtwq1AEtPoXEmN5+F+g@mail.gmail.com>
 <CALuQghbeW9myoQVMEJJYQsEiKCtEr-fbirwLcM-mtCSd3uEhAQ@mail.gmail.com>
 <CALuQghYcFacL9ZkEs4_CKSfi7DCG79_AwXRJ1_3H_W=665YLzw@mail.gmail.com>
 <CALuQghauszsSMNnizjrAtHPetLGaz1gcaZtXoC3kkcGi_mj5-g@mail.gmail.com>
 <CALuQghbhkvW+uiwOBNAx-R874_=DeZ89MtSWmKbWNFfBKnMLew@mail.gmail.com>
 <CALuQghYn1isgPCnOBiQoGjnQu=v3b4EVSfd1yJBRF2CSvGHyzg@mail.gmail.com>
 <CALuQghYZDQ606XPJFJoOzX-NGNQq2h17DZG=n2ovThAqUe1emw@mail.gmail.com>
 <CALuQghYJC-RLFuzDLMOac_2LhyaQwXuXCSmF87XFjamNt8XXDg@mail.gmail.com>
 <CALuQghYz41R-NwE7G1LkyPJ=xtUSSJfRzQzp4st2jvwctH8WMA@mail.gmail.com>
 <CALuQghYXOOSbEJNvtLQrF5dckRBoMw110SjeKY3wEWcC-JWPPA@mail.gmail.com>
 <CALuQghZ7c3Db6tZiFYK18GLqq1YK-A10QU7rz5AgAbRn9NkMFw@mail.gmail.com>
 <CALuQghYwb=g0BoQEPqWqBXsuha6m3OREBuaBgt-Nx7nUCYiYJA@mail.gmail.com>
 <CALuQghbaFiSA_yTtFVGTnEXBbN+S8-zRfeDtivVQLFD6_xhctg@mail.gmail.com>
 <CALuQghYvcD_Ts-V8quteVH8xOJirP70FknBn=D6938+SXn8UOQ@mail.gmail.com>
 <CALuQghav55B5geMw_gMmRYiKmdMMW__4M5-itdfH=ixNeDgcxg@mail.gmail.com>
 <CALuQghYSwHZo-2NgKdz4wpoEetS0DadfJDkFB9JKKropKOq=FA@mail.gmail.com>
 <CALuQghax_hJKAK0tSgiJj4GnAmwExcZqL53PRHjUocczkpsRwQ@mail.gmail.com>
 <CALuQghY9VZAtrn34V6k-5y3xKuNPQ+ydXBVmXS6iVUyRP1eTBw@mail.gmail.com>
 <CALuQghZs2a-qTdm9o+0eN600ESEGWc=HYHEzsKt9rae_OKreMA@mail.gmail.com>
 <CALuQghbJ55jh-tybsXfsY6wPdZsiJsXKQhQDTckEAe-20Tfjpg@mail.gmail.com>
 <CALuQghZF+j+E43Jv6=uOZu7AzDcpuPpFPWnRYOY8LzfrR-Sm0g@mail.gmail.com>
 <CALuQghY2UnSo6BJov-Yi1-Y_qvPUMdC2sBDwzXYvPo2J0w6ymw@mail.gmail.com>
 <CALuQghZzwraNKhigEuaoNMYZdWkCOW62Oq7gGxieWcwhi7MjpQ@mail.gmail.com>
 <CALuQghZYNGtG09YxR2zMOAHhXPMxq=K+8tq6O4H=H=1H2iMO8g@mail.gmail.com>
 <CALuQghZM6G+m97rjQp6zyHLHsGcZGYpSbXFYSaURxHABconYEw@mail.gmail.com> <CALuQghawzsC02hSt1LHORv1E223wp18R0KPAvU6D7V+nETpZVg@mail.gmail.com>
From:   Kenneth Johnson <edwardnaudorf@gmail.com>
Date:   Tue, 28 Apr 2020 09:34:14 -0700
Message-ID: <CALuQghbNWyKimxFsVhFTCk-ofHz6gUauu74b+eTDSUXi2CmuuQ@mail.gmail.com>
Subject: Investment Manager
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello,
I am Kenneth Johnson working with a business consultant.
There is a transaction of $1.4 billion dollars here that own by Arab
man if you have interest you need to come down to Gambia discuss
percentage with him.
Regards,
Kenneth Johnson
