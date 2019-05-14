Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CD1C338
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENGZM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 02:25:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7396 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfENGZM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 02:25:12 -0400
X-UUID: 888130a2ae434c868c45adbfc53d91f2-20190514
X-UUID: 888130a2ae434c868c45adbfc53d91f2-20190514
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1714811144; Tue, 14 May 2019 14:25:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 14:25:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 14:25:01 +0800
Message-ID: <1557815101.24427.7.camel@mtkswgap22>
Subject: Re: [PATCH v1 0/3] scsi: ufs: add error handlings of auto-hibern8
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        <sayalil@codeaurora.org>, <subhashj@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <evgreen@chromium.org>,
        <beanhuo@micron.com>
Date:   Tue, 14 May 2019 14:25:01 +0800
In-Reply-To: <55818bc4-d464-bb35-25bb-9ef87af8224e@free.fr>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
         <55818bc4-d464-bb35-25bb-9ef87af8224e@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Marc,

Thank you so much for below suggestions. I will fix them all in next
version.

On Mon, 2019-05-13 at 16:51 +0200, Marc Gonzalez wrote:
> On 13/05/2019 16:36, Stanley Chu wrote:
> 
> > Currently auto-hibern8 is activated if host supports
> > auto-hibern8 capability. However no error handlings are existed thus
> > this feature is kind of risky.
> 
> This last sentence is not very idiomatic.
> 
> I would suggest:
> "However, error-handling is not implemented, which makes the feature
> somewhat risky."
> 
> > If "Hibernate Enter" or "Hibernate Exit" fail happens
> 
> I would suggest:
> If either "Hibernate Enter" or "Hibernate Exit" fail during ...
> 
> > during auto-hibern8 flow, the corresponding interrupt
> > "UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
> > according to UFS specification.
> > 
> > This patch adds auto-hibern8 error handlings:
> 
> error-handling
> 
> > - Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
> >   auto-hibern8 feature is activated.
> 
> I just want to take this opportunity to ask a rhetorical question.
> 
> Who in the Great Heavens thought it would be a good idea to call the
> feature "auto-hibern8" ?
> 
> Was it really worth it to save 2 characters by writing "8" instead
> of "ate" ?
> 
> This bugs me so much that I just might send a patch to fix it up.

As far as I know, the term "HIBERN8" is mentioned in all UFS related
specifications, like UFS, UFSHCI, UniPro and M-PHY. So probably this
abbreviation has existed for a long time.

> 
> Regards.

Thanks,

Stanley


