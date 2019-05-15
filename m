Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E01E6ED
	for <lists+linux-scsi@lfdr.de>; Wed, 15 May 2019 04:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEOCw2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 22:52:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20754 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbfEOCw2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 22:52:28 -0400
X-UUID: 5c5ebb44d7f543d5a361d67b06aa44fb-20190515
X-UUID: 5c5ebb44d7f543d5a361d67b06aa44fb-20190515
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 323553533; Wed, 15 May 2019 10:52:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 May 2019 10:52:11 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 May 2019 10:52:12 +0800
Message-ID: <1557888732.24427.37.camel@mtkswgap22>
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
Date:   Wed, 15 May 2019 10:52:12 +0800
In-Reply-To: <BN7PR08MB56840A3CD3BA7C107D0230CADB080@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
         <1557758186-18706-3-git-send-email-stanley.chu@mediatek.com>
         <BN7PR08MB568438668FC7C90A1284F53DDB0F0@BN7PR08MB5684.namprd08.prod.outlook.com>
         <1557817102.24427.20.camel@mtkswgap22>
         <BN7PR08MB56840A3CD3BA7C107D0230CADB080@BN7PR08MB5684.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: F333B7094BABB211A3915B8D030D67B65CA83E38D06C435B30630073FF8167922000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bean,

On Tue, 2019-05-14 at 11:14 +0000, Bean Huo (beanhuo) wrote:
> Hi, Stanley
> Thanks for reply.
> 
> >
> >On Mon, 2019-05-13 at 18:21 +0000, Bean Huo (beanhuo) wrote:
> >> Hi, Stanley
> >>
> >> >+
> >> >+static inline bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
> >> >+						u32 intr_mask)
> >> >+{
> >> >+	return (ufshcd_is_auto_hibern8_supported(hba) &&
> >> >+		!hba->uic_async_done &&
> >>
> >> Here check if uic_async_done is NULL, no big problem so far, but not safe
> >enough.
> >> How about setting a flag in ufshcd_auto_hibern8_enable(),
> >
> >>
> >> I concern about how to compatible with auto_hibern8 disabled condition.
> >
> >Currently auto-hibern8 disabling method is not implemented in mainstream,
> >so an "enabling" flag may looks redundant unless disabling path is really
> >existed.
> >
> Did you try to update Auto-Hibernate Idle Timer with 0 through '/sys'  (scsi: ufs: Add support for Auto-Hibernate Idle Timer)? 
> I don't know if this will disable your UFS controller Auto-Hibernate.
> If having a look at UFS host Spec, software writes “0” to disable Auto-Hibernate Idle Timer.
> Sorry I cannot verify this on my platform since it doesn't support auto-hibernate.
> 

Sorry I missed this /sys interface for Auto-Hibernate control.

Yes, I have tested "Auto-Hibernate disabled" case, in this case,
UIC_HIBERNATE_ENTER and UIC_HIBERNATE_EXIT interrupts comes only if
Manual-Hibernate is performed and waiting for completion. Both
interrupts will not be identified as Auto-Hibernate errors by checking
hba->uic_async_done.

As for your concerning, I would like to make "Auto-Hibernate error
detection" more precise in next version: Use below conditions instead of
checking hba->uic_async_done:

As-is:

static inline bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
						u32 intr_mask)
{
	return (ufshcd_is_auto_hibern8_supported(hba) &&
		!hba->uic_async_done &&
		(intr_mask & UFSHCD_UIC_AH8_ERROR_MASK));
}

To-be:

static bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
						u32 intr_mask)
{
	if (!ufshcd_is_auto_hibern8_supported(hba))
		return false;

	if (!(intr_mask & UFSHCD_UIC_AH8_ERROR_MASK))
		return false;

	if (hba->active_uic_cmd &&
	    ((hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_ENTER) ||
	    (hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_EXIT)))
		return false;

	return true;
}

What would you think about this change?

> 
> >I agree that checking hba->uic_async_done here does not look so intuitive.
> >However even if auto-hibern8 is disabled, these checks could be safe enough
> >because both "UIC_HIBERNATE_ENTER" and "UIC_HIBERNATE_EXIT" are
> >raised only if "manual-hibernate" is performed, and in this case hba-
> >>uic_async_done shall be true.
> >
> Yes, most of cases ,this is no problem.
> 
> >Anything else or corner case I missed?
> >
> The others are fine. I only concern checking hba->uic_async_done.
> 
> //Bean

Many thanks,
Stanley



