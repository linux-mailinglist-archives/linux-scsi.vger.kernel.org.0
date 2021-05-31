Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E639692D
	for <lists+linux-scsi@lfdr.de>; Mon, 31 May 2021 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEaVFD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 May 2021 17:05:03 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33485 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaVFC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 May 2021 17:05:02 -0400
Received: by mail-pf1-f180.google.com with SMTP id f22so9837402pfn.0;
        Mon, 31 May 2021 14:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hlrHh1W/3/I/nMpqZaK/zqPdUpvmV3MptL5iLtxUBAk=;
        b=sp21eO9olEACtmpecWBoIl6kU8UsMFTKTx9RUu2UsNHyZqaMQjEB6cQkizxvhc6LRc
         vBXCYFOlU/Z+ewJ1EBaI3v5I7DenT3b87hQHkmXnKRlul7BDNBrqZKX/rZ0h04GVWZ5H
         yT7JPptRe4lBW01BzSwOPo6RHHR0XBi0bTQHh5oKB0DPUz2LiA0liwRPi6LTIwgFiZDy
         Q/Ox+Ulzp0A4KTqOCdONEUJpYH3Ej5WIrSGwLkVhJaK56hSiLKy1tpm0+umC8fR38DO6
         RdDuzEIvEdVs2XDsk57HunNw1+vv6hrKCeVilOpNRh6SSe2NBflJrFUacEKTOAETmBpP
         y7aA==
X-Gm-Message-State: AOAM531qccSCmVkpMRJ82mH5kBSyPNtGKDTPF5Ccxr20hmTR0TnW6JS0
        OTx052Pi3nd3DjMJDwRbU/fVq7FRbTM=
X-Google-Smtp-Source: ABdhPJwBMEaHPADR3SDZr2bzqBeVtpd4JrMDl9/tW9VuNUh4yM8W276xvLeLvzMuyW4bNjEYbV1MqQ==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr24123653pgh.272.1622495000076;
        Mon, 31 May 2021 14:03:20 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y129sm11078904pfy.123.2021.05.31.14.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 14:03:19 -0700 (PDT)
Subject: Re: [PATCH] scsi: ufs: Fix a kernel-doc related formatting issue
To:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        tomas.winkler@intel.com, cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210531163122.451375-1-huobean@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <018111c3-8b28-49a3-d171-26ce38476d4c@acm.org>
Date:   Mon, 31 May 2021 14:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531163122.451375-1-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/31/21 9:31 AM, Bean Huo wrote:
> +/* ufs_rpmb_wlun_template - Describes UFS rpmb wlun. Used only to send uac. */

Hi Bean,

For future patches, since RPMB, WLUN and UAC are all abbreviations,
please capitalize these.

Thanks,

Bart.
