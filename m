Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9312D3B77
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 07:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgLIGdL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 01:33:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9134 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLIGdL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 01:33:11 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CrRzJ6djFz15Z3P;
        Wed,  9 Dec 2020 14:31:56 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 14:32:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] scsi: ufs-mediatek: use correct path to fix compiling error
Date:   Wed, 9 Dec 2020 14:31:43 +0800
Message-ID: <20201209063144.1840-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch is based on the latest linux-next code. So the Fixes commit-id
maybe changed when it merged int v5.11-rc1.


Zhen Lei (1):
  scsi: ufs-mediatek: use correct path to fix compiling error

 drivers/scsi/ufs/ufs-mediatek-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.0.106.g9fadedd


