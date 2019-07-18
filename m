Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D236C8B7
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 07:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGRFV3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jul 2019 01:21:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbfGRFV2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Jul 2019 01:21:28 -0400
X-UUID: e4bd01a9c31446e2b75157f86e6bc0cd-20190718
X-UUID: e4bd01a9c31446e2b75157f86e6bc0cd-20190718
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 790858207; Thu, 18 Jul 2019 13:21:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 13:21:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 13:21:02 +0800
Message-ID: <1563427263.7235.6.camel@mtkswgap22>
Subject: Re: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
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
Date:   Thu, 18 Jul 2019 13:21:03 +0800
In-Reply-To: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri, Alim and Pedrom,

Gentle ping for this fix.

On Fri, 2019-07-12 at 12:44 +0800, Stanley Chu wrote:
> Currently bits in hba->outstanding_tasks are cleared only after their
> corresponding task management commands are successfully done by
> __ufshcd_issue_tm_cmd().
> 
> If timeout happens in a task management command, its corresponding
> bit in hba->outstanding_tasks will not be cleared until next task
> management command with the same tag used successfully finishes.‧
> 
> This is wrong and can lead to some issues, like power consumpton issue.
> For example, ufshcd_release() and ufshcd_gate_work() will do nothing
> if hba->outstanding_tasks is not zero even if both UFS host and devices
> are actually idle.
> 
> Because error handling flow, i.e., ufshcd_reset_and_restore(), will be
> triggered after any task management command times out, we fix this by
> clearing corresponding hba->outstanding_tasks bits during this flow.
> To achieve this, we need a mask to track timed-out commands and thus
> error handling flow can clear their tags specifically.
> 
> Stanley Chu (2):
>   scsi: ufs: Make new function for clearing outstanding task bits
>   scsi: ufs: Fix broken hba->outstanding_tasks
> 
>  drivers/scsi/ufs/ufshcd.c | 49 +++++++++++++++++++++++++++++++++------
>  drivers/scsi/ufs/ufshcd.h |  1 +
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 

Thanks,
Stanley

