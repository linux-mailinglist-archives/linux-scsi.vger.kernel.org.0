Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A0781F4
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfG1WJe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 18:09:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42440 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfG1WJd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 28 Jul 2019 18:09:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so56606546lje.9
        for <linux-scsi@vger.kernel.org>; Sun, 28 Jul 2019 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX1hpidhvVd2B1jpZNjhTE/QLOo8ZOGtRfMqnoho3GM=;
        b=WSHsBcXZ7JERbbGCMkWI5YCfQg8C14MBHZJm3Hue5oF7J5DyqJl6tQpVbngQ8q52c8
         2ScdHTPvRGepFlQLYPWxw2+AXctL99KLBkHSFQ8O4PukhjvxlRN35e1Mbo2a9eAsRy1L
         kJeMT5pviW3zV/uCvwdcsc4DwJCul8jcDjVvLZOXt+LUuxErTKp4EjWHWw8RditvsrEk
         Ql1emScyRfzwoGqoycMYh2gQ9ULJv2iQuCMF5g1ImxA1dcbqvRfi1uanPOPq3N2SLAHn
         ak5s40rLE1mfZYkTU+iKfp8r8S/5/BMctQsqsZ8htKP912yknb+5p451H5XxfSf1/42x
         1cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX1hpidhvVd2B1jpZNjhTE/QLOo8ZOGtRfMqnoho3GM=;
        b=ExMyBKKb09eufPPo2XcjLdlpS8fi/H9Wwo1kjih+AzIG0OUdhcn08hjbYgmXAb49TX
         sgDwBhhrIOulOB7ofc1mBodjjkIvj78hp6H4WQfGyE1CXUKUE8e+6aZ2y6B+Oy7h5mH6
         592RGJLdC1MPa8N+TpAeGCyqUBLwa/HWEcgvIDjDB9YXjAp1CetmcDN1PkbJO39Ctw1H
         M3N9fKzgKSHHyxInZu9pY//Lcq+1ji22FBFkWwPsO05Yu4DUSC2A4k9MerfGAECUbsms
         dP0+n+dEqi///+aoUd8ogq+oz9cwR1s2kNmBmwszuEG9YhM/CLTxL1gGxzdcTQYu6dcT
         wNXQ==
X-Gm-Message-State: APjAAAURlXbRyo3PTo783hkFEFM/enihOytBD8eK8B3Cq0Oobzu9R4Jl
        /Ck0S9uzYXkrY8fun+J/0QY9Qk8YLtFCkLlb76xYZw==
X-Google-Smtp-Source: APXvYqywJuBj32EcmV1j+DhpREz2WRlJ8AJL77FsJDcPL2Uh+1cobshd9SxF1ulQUi38gPjw1BTeSgp8v1gBCV2YbpE=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr8043666ljs.54.1564351771778;
 Sun, 28 Jul 2019 15:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190606010249.3538-1-bjorn.andersson@linaro.org> <20190606010249.3538-3-bjorn.andersson@linaro.org>
In-Reply-To: <20190606010249.3538-3-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:09:20 +0200
Message-ID: <CACRpkdbSrGq7ma2ywyQ89N8PKQWLVUiz8NqE4iGyctyENcBKSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: ufs: Allow resetting the UFS device
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 6, 2019 at 3:02 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Acquire the device-reset GPIO and toggle this to reset the UFS device
> during initialization and host reset.
>
> Based on downstream support implemented by Subhash Jadavani
> <subhashj@codeaurora.org>.
>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I agree with Rob that just "reset-gpios" looks better.
Otherwise:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
