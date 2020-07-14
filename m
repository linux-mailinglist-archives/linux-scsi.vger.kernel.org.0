Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68821F847
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgGNRdU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgGNRdT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Jul 2020 13:33:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83261C08C5C1
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2020 10:33:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so7318479plr.2
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2020 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pG3yhaFcMR8nDMPUd0cgqstI0QVzo58QIP2Jui7dQwo=;
        b=jn+NmlUwmD1u2hIfhFbmu8A+bV/3z1hiwPdxmZtVrhWL87GDfrZ1B1t8B7LAvWqtV6
         TXPAnKwGlZm2FRH+x1jTN47XdQ1bR4cUtP1NbizAoXZqn/iGhTqDy1M4FJDoP7c17tIF
         MV4y46nvSUgGp1PQDNCvyRh+haD912m6Bzoeyz+Xd2rGo4PiSEc7Wu5hd85EQSa7SuQU
         wiiSUjAfvnC6BUUxU1eEHHZ+PugBHEuWO0QchIjWB+r/Hp9a0hNUUd4N8i6gkTNq424a
         BJIUOFJVmqd8BHJgsJGd5L3KXy6jFDX3xaGizJvMK3GN+nrhtao4PfVlgh4SIdlXlHJe
         5OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pG3yhaFcMR8nDMPUd0cgqstI0QVzo58QIP2Jui7dQwo=;
        b=CUS+BQrG92wJqXBKXrxKofarM8lE2dFpdVq9UN452RA6iuPTAPVLCHt8ObHWYrzZm4
         qWJdDHO4POLx/O16IFSPNjVIoLgMsZ5OsEGXARksh66uNoLrbda4ke0SMKsDCbiP0XqY
         mmy5Gu4lhpAJPSPkTHBEnwTuiVyed6MPiAIi45wfrpjJ2q9n/zh8s6v/TktNa+ntjkSo
         jJWG3DfVQl7AXAhWQw/3rkOvktJPyW0Y8G/jK713szhG+/nI0BMiYgyeEwNo2QP272Lt
         QYZ0p8Wv4Rc1gM1l/wcKQlddBlWPD+rR5z6cv4Iv6LEKfmTNLO5VPotKBTOuhrxiufg8
         qr3w==
X-Gm-Message-State: AOAM530bdL3HJ3jw9L8R8jgGh4fk0XlbXNPP9Bv+4XgA7qwrojzayw7B
        HjNnIG+M8ZEkEX+jDm9DaO66Aw==
X-Google-Smtp-Source: ABdhPJzSUSkC3rUOoK1pt3an9D4+ZqYUMWEjgXpObpBOLxGSWWijC76JxUZ0J7xPCo3o3J3+GPYRfQ==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr5970834pjb.196.1594747998203;
        Tue, 14 Jul 2020 10:33:18 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y24sm18698027pfp.217.2020.07.14.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:33:17 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:31:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Can Guo <cang@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        Steev Klimaszewski <steev@kali.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v6 3/5] arm64: dts: sdm845: add Inline Crypto Engine
 registers and clock
Message-ID: <20200714173111.GG388985@builder.lan>
References: <20200710072013.177481-1-ebiggers@kernel.org>
 <20200710072013.177481-4-ebiggers@kernel.org>
 <yq1ft9uqj6u.fsf@ca-mkp.ca.oracle.com>
 <20200714161516.GA1064009@gmail.com>
 <CAL_Jsq+t1h4w8C361vguw1co_vnbMKs3q4qWR4=jwAKr1Vm80g@mail.gmail.com>
 <20200714164353.GB1064009@gmail.com>
 <CAL_JsqK-wUuo6azYseC35R=Q509=h9-v4gFvcvy8wXrDgSw5ZQ@mail.gmail.com>
 <20200714171203.GC1064009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714171203.GC1064009@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue 14 Jul 10:12 PDT 2020, Eric Biggers wrote:

> On Tue, Jul 14, 2020 at 10:59:44AM -0600, Rob Herring wrote:
> > On Tue, Jul 14, 2020 at 10:43 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 10:35:12AM -0600, Rob Herring wrote:
> > > > On Tue, Jul 14, 2020 at 10:15 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2020 at 10:16:04AM -0400, Martin K. Petersen wrote:
> > > > > >
> > > > > > Eric,
> > > > > >
> > > > > > > Add the vendor-specific registers and clock for Qualcomm ICE (Inline
> > > > > > > Crypto Engine) to the device tree node for the UFS host controller on
> > > > > > > sdm845, so that the ufs-qcom driver will be able to use inline crypto.
> > > > > >
> > > > > > I would like to see an Acked-by for this patch before I merge it.
> > > > > >
> > > > >
> > > > > Andy, Bjorn, or Rob: can you give Acked-by?
> > > >
> > > > DTS changes should go in via the QCom tree.
> > > >
> > >
> > > So, the DTS patch can't be applied without the driver patches since then the
> > > driver would misinterpret the ICE registers as the dev_ref_clk_ctrl registers.
> > 
> > That sounds broken, but there's no context here for me to comment
> > further. DTS changes should work with old/stable kernels. I'd suggest
> > you get a review from Bjorn on the driver first.
> > 
> 
> The "breaking" change is that the dev_ref_clk_ctrl registers are now identified
> by name instead of assumed to be index 1.
> 
> A reviewer had complained about the device-mapper bindings of this driver before
> (https://lkml.kernel.org/r/158334171487.7173.5606223900174949177@swboyd.mtv.corp.google.com).
> Changing to identifying the registers by name seemed like an improvement.
> 
> If needed I can add a hole at index 1 to make the DTS changes work with
> old/stable kernels too, but I didn't know that is a requirement.  (Normally for
> Linux kernel development, kernel-internal refactoring is always allowed
> upstream.)  If I do this, would this hack have to be carried forever, or would
> we be able to fix it up eventually?  Is there any deprecation period for DTS, or
> do the latest DTS have to work with a 20 year old kernel?
> 

The problem here is that DT binding refactoring is not kernel-internal.
It's two different projects living in the same git.

There's a wish from various people that we make sure that new DTS
continues to work with existing kernels. This is a nice in theory
there's a lot of examples where we simply couldn't anticipate how future
bindings would look. A particular example is that this prohibits most
advancement in power management.


But afaict what you describe above would make a new kernel failing to
operate with the old DTS and that we have agreed to avoid.
So I think the appropriate way to deal with this is to request the reg
byname to detect the new binding and if that fails then assume that
index 1 is dev_ref_clk_ctrl.


There are cases where we just decide not to be backwards compatible, but
it's pretty rare. As for deprecation, I think 1-2 LTS releases is
sufficient, at that time scale it doesn't make sense to sit with an old
DTB anyways (given the current pace of advancements in the kernel).

Regards,
Bjorn
