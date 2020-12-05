Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C92CF913
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLECq2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 21:46:28 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:10266 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLECq1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Dec 2020 21:46:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607136367; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=cg6LwuBMaMkBOwLfQQov9goTt87+/7c56RGsunD/YnA=; b=q5/PmO6geatBDn6nGJCyeDx9gHw1VvMcEfrR8jMYM4++kDMdYhJq9mP84JgddD8k2Cc9cUEC
 tZJqDW83+uBz1xGxDoZydgHXvNmkiFuOWEb4kSHAGM3wUeHyKof30ntWZW16OFiqk4/tWT5O
 EppocAGZJLzTRzmilSmemqrl+yA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fcaf453aac94550978b7b2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 05 Dec 2020 02:45:39
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62801C43467; Sat,  5 Dec 2020 02:45:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.8.168] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2515DC433C6;
        Sat,  5 Dec 2020 02:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2515DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v1 0/3] Refine error history and introduce notify_event
 vop
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     beanhuo@micron.com, cang@codeaurora.org, matthias.bgg@gmail.com,
        bvanassche@acm.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com,
        jiajie.hao@mediatek.com, alice.chao@mediatek.com,
        huadian.liu@mediatek.com
References: <20201126053839.25889-1-stanley.chu@mediatek.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <408e4cb7-0078-1368-d3f2-21fd6c245a82@codeaurora.org>
Date:   Fri, 4 Dec 2020 18:45:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201126053839.25889-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/25/2020 9:38 PM, Stanley Chu wrote:
> Hi,
> This series refines error history functions and introduce a new notify_event vop to allow vendor to get notified of important events.
> 
> Stanley Chu (3):
>    scsi: ufs: Add error history for abort event in UFS Device W-LUN
>    scsi: ufs: Refine error history functions
>    scsi: ufs: Introduce notify_event variant function
> 
>   drivers/scsi/ufs/ufshcd.c | 122 ++++++++++++++++++++++----------------
>   drivers/scsi/ufs/ufshcd.h |  82 ++++++++++++-------------
>   2 files changed, 112 insertions(+), 92 deletions(-)
> 

Hi Stanley,

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

Please add to the series.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
