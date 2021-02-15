Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242131C030
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Feb 2021 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBORMI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Feb 2021 12:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhBORLE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 15 Feb 2021 12:11:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9AC061574;
        Mon, 15 Feb 2021 09:10:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z22so8936130edb.9;
        Mon, 15 Feb 2021 09:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOxuPvdl3adnseOS0zir9JAd/6pRHQV8bpyRj8Y5/dU=;
        b=ZxSikTfHITLybPXlf2dSB2rpsC0vveAOGNMXuRm9/lAS3RV5+CCa8YSDKJRBMgi1HA
         8Kot76/XdQPRI2c0sMmDNrjvHLwuVNtjPVJDCi5wJSeW4i2mLhiSEqbspLYYv3jXjiwd
         9kvThjpu7/zgpH8nFQPzLzCwo5Dvx6GAB+sf4GmNZvkzAofDYzy7/dsDNksEzWx3CJr+
         PPXeQuqT9806UE2GYMHEu/vXiwa5KrNHgHwG+oQ2ytmjWXmloG5GLYbYoSpt7f5k5ZwN
         hXS6sxVECYih1d3fCGjBO+U2BW70P1W6iqxqJonrq3YSBhFKumDLXPrdRNXaBUcHH9Zl
         1oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOxuPvdl3adnseOS0zir9JAd/6pRHQV8bpyRj8Y5/dU=;
        b=HIHhEjlfivwHtf4YTd3xcaL87qOiqPfzUKj4c1FLBpfnyUoRI7jxgAJvuyewwZz2Mg
         474G0b4v7J6Fyz374Vogdp7hyzTOmuXFc5ftcxex8sETttOIfGZtoXfjneSwyLPoc2Wo
         2rn2se/VPip5dd9+2nTMBNkg1xcdtwukmGI/Qt03oQIvJfBQAmbmtCjUsOt0LPAI5nW3
         6gG7x9EQcgdqz1yCtMK+UGLBSk1lzQPSOOxHOmUazf2WjVk/HedFzBEsAOf2uLI1tomO
         y6DEbFgxuy1y1YapYRAxcl06HHcSIa6KfQILvNnW7a5mXNvFAKXxTv5oB+LM5n5j6nOV
         BkSQ==
X-Gm-Message-State: AOAM530hy7LcPjkGm82ZO8McBmRoBmjIFFyxVTOMUE8wjR7TprzUOirI
        YHNo2zduLbdjwY2DLp1tmos=
X-Google-Smtp-Source: ABdhPJwSDftHAs/uhYHf2xRzb5qW9EyWoZR2KMW7rWQF+Ep2cFcDsrGjzEhNPIJhEHr2qSAWSKpEYg==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr16591525edw.314.1613409023654;
        Mon, 15 Feb 2021 09:10:23 -0800 (PST)
Received: from ubuntu-laptop (ip5f5bec65.dynamic.kabel-deutschland.de. [95.91.236.101])
        by smtp.googlemail.com with ESMTPSA id x25sm10480712edv.65.2021.02.15.09.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 09:10:23 -0800 (PST)
Message-ID: <0b400e9e2d49f4ad14e873a3f4bb59aa099a5e7e.camel@gmail.com>
Subject: Re: [PATCH V2 3/4] scsi: ufs-debugfs: Add user-defined
 exception_event_mask
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Date:   Mon, 15 Feb 2021 18:10:21 +0100
In-Reply-To: <20210209062437.6954-4-adrian.hunter@intel.com>
References: <20210209062437.6954-1-adrian.hunter@intel.com>
         <20210209062437.6954-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2021-02-09 at 08:24 +0200, Adrian Hunter wrote:
> Allow users to enable specific exception events via debugfs.
> 
> The bits enabled by the driver ee_drv_ctrl are separated from the
> bits
> enabled by the user ee_usr_ctrl. The control mask ee_mask_ctrl is the
> logical-or of those two. A mutex is needed to ensure that the masks
> match
> what was written to the device.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Hi Adrian,
I tested this series patch on my platform, and you can add:

Acked-by: Bean Huo <beanhuo@micron.com>


Bean

