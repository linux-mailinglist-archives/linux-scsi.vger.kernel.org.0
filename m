Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EE2E9D88
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhADSz7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 13:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbhADSz6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Jan 2021 13:55:58 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6DC061794
        for <linux-scsi@vger.kernel.org>; Mon,  4 Jan 2021 10:55:18 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j20so27006346otq.5
        for <linux-scsi@vger.kernel.org>; Mon, 04 Jan 2021 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HCHUr50eCN2Mq1BFEjsYp3XRTEkB08z4GhkrFu84N5o=;
        b=MjK0591SdWSZ9DLSVpf0BxQENcnVdirWQsQ7aDl6SyoT5QHmyA95wA785FtmQXb4eS
         kalXUkp+oEIy1oKVvEwQb747gpJ/vNJAP/sksy9Q7KnNyGNmzOlvCGW5cXwd4sbfJ8U5
         N+0Nc5AFrEkuxtm0bCRm3uB1KbagVWrJ1d+uH4o95u0HT3CAa7V0Tbapga2pBgY1KNNn
         PGnZiHKUt+CiQUzoZugw3/kBILSrkuo3avoJyYzLtjZggUou0EAVDUKaxyAyU6KwjlRn
         ofG3WBujQoLydHQJZtcYadoIeYkN7X7nzm0JducjXJZwBdo9J9PyEcVL2nfk16HgQr1q
         ragQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HCHUr50eCN2Mq1BFEjsYp3XRTEkB08z4GhkrFu84N5o=;
        b=jIhlu7sW5YvcrPADGDyOBanCno3vEOvZK2GuR8gx4RchBSOs474aSJWSUUzYTn1ycH
         k1wig3mriVB7UrNsHsSZj32yZb09XBczo+ldHJgdHNDOAUby/8qyyy1TMMVUcw5B7ncQ
         Yj+SBh+VKbU94gnBKoJw5kFHoMz2E6p/tV9WTe8rLXh/XvRXbBaPmFxxvJ/J7u8EfVEk
         y29m1HINwGBKZHYaDaonkQL9wKEHLrQtxZIa7JpU7eukJv967RCQrGjUUWamjC5zBQPH
         qGGsdSAk0XzqhpQoboNgvuXPLsY6QAKJIIj1EpeKKweC/BjBDnx9Cw+l+EW/8VQ8nuWb
         P3eA==
X-Gm-Message-State: AOAM5326Bs/ZqTn+i0XYIbrB1GhOG6BFLowhubal4mVg/zIQGkdj7gOl
        SgGXsBa/mg/XV4VrAz+xlR+8Lw==
X-Google-Smtp-Source: ABdhPJynIT9V4QDAnYlHEj69tBxT9FlrJStSU7PSfvdY1dZKE/6gjjiShTwSh2OmegYcv02AXOLbBw==
X-Received: by 2002:a05:6830:1e41:: with SMTP id e1mr54050557otj.143.1609786517769;
        Mon, 04 Jan 2021 10:55:17 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t19sm14625846otp.36.2021.01.04.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:55:16 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:55:14 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ziqi Chen <ziqichen@codeaurora.org>, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, cang@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        kwmad.kim@samsung.com, stanley.chu@mediatek.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v4 1/1] scsi: ufs: Fix ufs power down/on specs
 violation
Message-ID: <X/NkktFnWI48XNcp@builder.lan>
References: <1608644981-46267-1-git-send-email-ziqichen@codeaurora.org>
 <e8980753-fa48-7862-e5ce-0d756d5d97a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8980753-fa48-7862-e5ce-0d756d5d97a6@intel.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon 04 Jan 03:15 CST 2021, Adrian Hunter wrote:

> On 22/12/20 3:49 pm, Ziqi Chen wrote:
> > As per specs, e.g, JESD220E chapter 7.2, while powering
> > off/on the ufs device, RST_N signal and REF_CLK signal
> > should be between VSS(Ground) and VCCQ/VCCQ2.
> > 
> > To flexibly control device reset line, refactor the function
> > ufschd_vops_device_reset(sturct ufs_hba *hba) to ufshcd_
> > vops_device_reset(sturct ufs_hba *hba, bool asserted). The
> > new parameter "bool asserted" is used to separate device reset
> > line pulling down from pulling up.
> 
> This patch assumes the power is controlled by voltage regulators, but for us
> it is controlled by firmware (ACPI), so it is not correct to change RST_n
> for all host controllers as you are doing.
> 
> Also we might need to use a firmware interface for device reset, in which
> case the 'asserted' value doe not make sense.
> 

Are you saying that the entire flip-flop-the-reset is a single firmware
operation in your case? If you look at the Mediatek driver, the
implementation of ufs_mtk_device_reset_ctrl() is a jump to firmware.


But perhaps "asserted" isn't the appropriate English word for saying
"the reset is in the resetting state"?

I just wanted to avoid the use of "high"/"lo" as if you look at the
Mediatek code they pass the expected line-level to the firmware, while
in the Qualcomm code we pass the logical state to the GPIO code which is
setup up as "active low" and thereby flip the meaning before hitting the
pad.

> Can we leave the device reset callback alone, and instead introduce a new
> variant operation for setting RST_n to match voltage regulator power changes?

Wouldn't this new function just have to look like the proposed patches?
In which case for existing platforms we'd have both?

How would you implement this, or would you simply skip implementing
this?

Regards,
Bjorn

