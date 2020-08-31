Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B463A257516
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHaIMF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 04:12:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbgHaIMD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 31 Aug 2020 04:12:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02B03BBA58750082DAEE;
        Mon, 31 Aug 2020 16:12:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 16:11:53 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 0/4] scsi: fnic: build warnings clean up
Date:   Mon, 31 Aug 2020 16:11:22 +0800
Message-ID: <20200831081126.3251288-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some build warnings cleanup.

Jason Yan (4):
  scsi: fnic: remove set but not used 'old_vlan'
  scsi: fnic: remove set but not used variable in
    is_fnic_fip_flogi_reject()
  scsi: fnic: remove set but not used 'fr_len'
  scsi: fnic: remove set but not used 'eth_hdrs_stripped'

 drivers/scsi/fnic/fnic_fcs.c  | 9 ---------
 drivers/scsi/fnic/fnic_main.c | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

-- 
2.25.4

