Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB904285F
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbfFLOFp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 10:05:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33922 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405816AbfFLOFp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Jun 2019 10:05:45 -0400
X-UUID: 83be6aecfdea4ad0a2711586fb332c1c-20190612
X-UUID: 83be6aecfdea4ad0a2711586fb332c1c-20190612
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 544594755; Wed, 12 Jun 2019 22:05:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 22:05:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 22:05:39 +0800
Message-ID: <1560348339.19782.8.camel@mtkswgap22>
Subject: Re: [PATCH v1] scsi: ufs: Avoid runtime suspend possibly being
 blocked forever
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        SCSI <linux-scsi@vger.kernel.org>, <stanley.chu@mediatek.com>
Date:   Wed, 12 Jun 2019 22:05:39 +0800
In-Reply-To: <f83162dc-8e27-b592-812e-e6a0176ea3cd@free.fr>
References: <1560325326-1598-1-git-send-email-stanley.chu@mediatek.com>
         <SN6PR04MB492546256F8F8635E7EE60C2FCEC0@SN6PR04MB4925.namprd04.prod.outlook.com>
         <f83162dc-8e27-b592-812e-e6a0176ea3cd@free.fr>
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

On Wed, 2019-06-12 at 13:30 +0200, Marc Gonzalez wrote:
> On 12/06/2019 13:10, Avri Altman wrote:
> 
> > On 12/06/2019 09:42, Stanley Chu wrote:
> > 
> >> Fixes: e3ce73d (scsi: ufs: fix bugs related to null pointer access and array size)
> > 
> > This code was inserted before platform_set_drvdata  in
> > 6269473 [SCSI] ufs: Add runtime PM support for UFS host controller driver.
> > Why do you point to e3ce73d?
> 
> Please note that the (current) convention is to show 12 characters
> (not 7) for git hashes:

Thanks for your remind :-)
I will fix it in next version.

> 
> 	git config --global core.abbrev 12
> 
> https://public-inbox.org/git/CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com/
> 
> Regards.

Thanks.
Stanley

