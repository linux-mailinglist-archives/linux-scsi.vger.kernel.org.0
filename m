Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AEA229AA
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 03:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfETBPq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 May 2019 21:15:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729642AbfETBPq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 May 2019 21:15:46 -0400
X-UUID: 2188c294f91343818c3ef48c5a6f9146-20190520
X-UUID: 2188c294f91343818c3ef48c5a6f9146-20190520
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1675438039; Mon, 20 May 2019 09:15:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 09:15:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 09:15:38 +0800
Message-ID: <1558314937.660.2.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/3] scsi: ufs: Add error handling of Auto-Hibernate
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>,
        Peter Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=8F=8B=29?= 
        <peter.wang@mediatek.com>,
        Chun-Hung Wu =?UTF-8?Q?=28=E5=B7=AB=E9=A7=BF=E5=AE=8F=29?= 
        <Chun-hung.Wu@mediatek.com>,
        Andy Teng =?UTF-8?Q?=28=E9=84=A7=E5=A6=82=E5=AE=8F=29?= 
        <Andy.Teng@mediatek.com>
Date:   Mon, 20 May 2019 09:15:37 +0800
In-Reply-To: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 98DB3DEF6BAFB6C6F7C95ADEF238E8BF6072C530D9204002251DC5A7057FDE232000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri, Alim, Pedro,

Gentle ping for this patch.

On Wed, 2019-05-15 at 17:36 +0800, Stanley Chu wrote:
> Currently auto-hibernate is activated if host supports
> auto-hibern8 capability. However error-handling is not implemented,
> which makes the feature somewhat risky.
> 
> If either "Hibernate Enter" or "Hibernate Exit" fail during
> auto-hibernate flow, the corresponding interrupt
> "UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
> according to UFS specification.
> 
> This patch adds auto-hibernate error-handling:
> 
> - Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
>   auto-hibernate feature is activated.
> 
> - If fail happens, trigger error-handling just like "manual-hibernate"
>   fail and apply the same recovery flow: schedule UFS error handler in
>   ufshcd_check_errors(), and then do host reset and restore
>   in UFS error handler.
> 
> v2:
>  - Fix sentences in commit message (Marc Gonzalez)
>  - Make "Auto-Hibernate" error detection more precise (Bean Huo)
> 
> Stanley Chu (3):
>   scsi: ufs: Do not overwrite Auto-Hibernate timer
>   scsi: ufs: Add error-handling of Auto-Hibernate
>   scsi: ufs: Use re-factored Auto-Hibernate function
> 
>  drivers/scsi/ufs/ufshcd.c | 33 ++++++++++++++++++++++++++++++++-
>  drivers/scsi/ufs/ufshcd.h |  5 +++++
>  drivers/scsi/ufs/ufshci.h |  3 +++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
Thanks,
Stanley

