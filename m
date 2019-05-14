Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF71C38D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfENG6d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 02:58:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36114 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbfENG6c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 02:58:32 -0400
X-UUID: bd317bcca865465bbee98c4e76ad8607-20190514
X-UUID: bd317bcca865465bbee98c4e76ad8607-20190514
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1907136703; Tue, 14 May 2019 14:58:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 14:58:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 14:58:22 +0800
Message-ID: <1557817102.24427.20.camel@mtkswgap22>
Subject: RE: [EXT] [PATCH v1 2/3] scsi: ufs: add error handling of
 auto-hibern8
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 14 May 2019 14:58:22 +0800
In-Reply-To: <BN7PR08MB568438668FC7C90A1284F53DDB0F0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
         <1557758186-18706-3-git-send-email-stanley.chu@mediatek.com>
         <BN7PR08MB568438668FC7C90A1284F53DDB0F0@BN7PR08MB5684.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bean,

Thanks so much for review.

On Mon, 2019-05-13 at 18:21 +0000, Bean Huo (beanhuo) wrote:
> Hi, Stanley
> 
> >+
> >+static inline bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
> >+						u32 intr_mask)
> >+{
> >+	return (ufshcd_is_auto_hibern8_supported(hba) &&
> >+		!hba->uic_async_done &&
> 
> Here check if uic_async_done is NULL, no big problem so far, but not safe enough.
> How about setting a flag in ufshcd_auto_hibern8_enable(),

> 
> I concern about how to compatible with auto_hibern8 disabled condition.

Currently auto-hibern8 disabling method is not implemented in
mainstream, so an "enabling" flag may looks redundant unless disabling
path is really existed.

I agree that checking hba->uic_async_done here does not look so
intuitive. However even if auto-hibern8 is disabled, these checks could
be safe enough because both "UIC_HIBERNATE_ENTER" and
"UIC_HIBERNATE_EXIT" are raised only if "manual-hibernate" is performed,
and in this case hba->uic_async_done shall be true.

Anything else or corner case I missed?

> 
> 
> //Bean

Thanks,
Stanley

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


