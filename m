Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2382E182C
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Dec 2020 05:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgLWEl7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Dec 2020 23:41:59 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:63447 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgLWEl7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Dec 2020 23:41:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608698499; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qLARzNaefrjwPVPDeA1xStKL6aHUM5wgUliEp6OdikY=;
 b=Ec26IlaLr0qu48fP89NdNQdEfvORVZN4YG5qI+ax1cwqDHGzMtA94CvpNTKGDnRDs7VFopOW
 CO+qwd+htzsHQpGS0jooJGxzxD3lDDqkW8LgNi1zyeHVwvHFxTc1FlF4iKfe7BWpBhEZ+Uc2
 VeWUsSG6GmfHh3wdZ9ZHIF2FMbY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fe2ca656d011aad66249205 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 04:41:09
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B529EC43465; Wed, 23 Dec 2020 04:41:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A4C5C433C6;
        Wed, 23 Dec 2020 04:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Dec 2020 12:41:08 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com,
        jiajie.hao@mediatek.com, alice.chao@mediatek.com
Subject: Re: [PATCH v1] scsi: ufs-mediatek: Enable
 UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
In-Reply-To: <1608697172.14045.5.camel@mtkswgap22>
References: <20201222072928.32328-1-stanley.chu@mediatek.com>
 <c862866ec97516a7ffb891e5de3d132d@codeaurora.org>
 <1608697172.14045.5.camel@mtkswgap22>
Message-ID: <c83d34ca8b0338526f6440f1c4ee43dd@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-23 12:19, Stanley Chu wrote:
> Hi Can,
> 
> On Tue, 2020-12-22 at 19:34 +0800, Can Guo wrote:
>> On 2020-12-22 15:29, Stanley Chu wrote:
>> > Flush during hibern8 is sufficient on MediaTek platforms, thus
>> > enable UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL to skip enabling
>> > fWriteBoosterBufferFlush during WriteBooster initialization.
>> >
>> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
>> > ---
>> >  drivers/scsi/ufs/ufs-mediatek.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/scsi/ufs/ufs-mediatek.c
>> > b/drivers/scsi/ufs/ufs-mediatek.c
>> > index 80618af7c872..c55202b92a43 100644
>> > --- a/drivers/scsi/ufs/ufs-mediatek.c
>> > +++ b/drivers/scsi/ufs/ufs-mediatek.c
>> > @@ -661,6 +661,7 @@ static int ufs_mtk_init(struct ufs_hba *hba)
>> >
>> >  	/* Enable WriteBooster */
>> >  	hba->caps |= UFSHCD_CAP_WB_EN;
>> > +	hba->quirks |= UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL;
>> >  	hba->vps->wb_flush_threshold = UFS_WB_BUF_REMAIN_PERCENT(80);
>> >
>> >  	if (host->caps & UFS_MTK_CAP_DISABLE_AH8)
>> 
>> I guess we need it too...
> 
> AHHA, if you decide to add this in your platform too later, maybe we
> could change the way it does: Keep manual flush disabled by default and
> remove this quirk.
> 

Yeah... I will get back with an answer later.

Thanks,

Can Guo.

> Thanks,
> Stanley Chu
>> 
>> Change LGTM.
>> 
>> Regards,
>> 
>> Can Guo.
