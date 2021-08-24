Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A53F55CD
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Aug 2021 04:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhHXC14 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Aug 2021 22:27:56 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:37467 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHXC1z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Aug 2021 22:27:55 -0400
Received: by mail-pl1-f175.google.com with SMTP id n12so11349112plf.4
        for <linux-scsi@vger.kernel.org>; Mon, 23 Aug 2021 19:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZ3U4A1CkTnOaNRkCP7+QCUp6889+knHq48F9bRO5+o=;
        b=dIvWaygyDeNOhQO2AgVFHW8kb48RlfoiJvbzUSS3HCVgYFVUbtM9eNDSNi2qBQAw7i
         TjUI9deim0sPNSx+1unxHxHiOEYiG0V0rViN24791s4zCOT9i3Squ2rZvr84FKyMU8vS
         qL6y4f4ej63RCmPORKbEkgJKVQB4ikDPlZuoMAtzfwxuYmf4LnFNAt9qYfsq643v+KR+
         5ZJMnSiPnmLEzrdW9ScyROPFj5IKYBNZGq5jQFagu37zlcS2boN4HpWIKWMwu2kDr+jD
         GAQ+PYHexBPKA2PNhPEd8eYxmeJ/bPqw15q/bOrvZ41DSd3U7OUCWkyeCT7+r6eC9DZ/
         veXg==
X-Gm-Message-State: AOAM531azD6SE3r/mI+DSxde2ZGBSFc/369acymjTRAYOQiym6y2q8v9
        Hfyu63mzoH9WIA4zxH5xQaxJdNh69Rc=
X-Google-Smtp-Source: ABdhPJzvvOt9HgYVFDsmLLD6+HHLMjQbm/ZZR2nuPOOiMJE+HQ1P+DPQErN1l/QpXS3sKLabqaBbrg==
X-Received: by 2002:a17:90a:7141:: with SMTP id g1mr1792744pjs.142.1629772031421;
        Mon, 23 Aug 2021 19:27:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:68:8a8:39ff:312? ([2601:647:4000:d7:68:8a8:39ff:312])
        by smtp.gmail.com with ESMTPSA id e11sm297899pfn.49.2021.08.23.19.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 19:27:10 -0700 (PDT)
Subject: Re: [PATCH V2] scsi: ufs: Fix ufshcd_request_sense_async() for
 Samsung KLUFG8RHDA-B2D1
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-scsi@vger.kernel.org
References: <20210823050117.11608-1-adrian.hunter@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a85f2513-c063-eaf1-ad02-b15a164abbe9@acm.org>
Date:   Mon, 23 Aug 2021 19:27:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823050117.11608-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/22/21 10:01 PM, Adrian Hunter wrote:
> Samsung KLUFG8RHDA-B2D1 does not clear the unit attention condition if the
> length is zero. So go back to requesting all the sense data, as it was
> before patch "scsi: ufs: Request sense data asynchronously". That is
> simpler than creating and maintaining a quirk for affected devices.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
