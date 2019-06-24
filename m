Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5049650491
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfFXIaE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:04 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36434 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:04 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8LFI5018312
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=0Jl9opByMl2foQaulfwcB17a/TK3mV6W9rftvoCWFgU=;
 b=kKHG9grTLUvLTQE2GcUsdbwp0ZRqLtDBhk+KnyQ8q1IW679Hce1DL02cfFmsF4NgX3C6
 svIDuQrlr8lWFcvOoHCv+maPWbIWF2RRMKsRg4phBA7/G1nxL5lSjnDP55dJqs+T+Xxx
 tv0kfhRtA7YA7s5Rupoy5egAN9DUTY0crETqu3iYqgpf9E0QatY0RHBSn3rQRXgiPITs
 c7uLSu4KNnzUAB3tvnUFtV3WuysyrhBqdPP7F9esrS/w/CDzJIObHrjSOtVvPN43SQaD
 qANgeVBH17Cc/pj/rV6fV4m6Fn73dL+FXKcBDtHRtSAjqyB/9Mmk+WAy810/tlCTbfeh bg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujdw7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:03 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:01 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:01 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2BBD43F704B;
        Mon, 24 Jun 2019 01:30:01 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8U1wM023109;
        Mon, 24 Jun 2019 01:30:01 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8U07p023108;
        Mon, 24 Jun 2019 01:30:00 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 0/6] bnx2fc: Update to the driver.
Date:   Mon, 24 Jun 2019 01:29:54 -0700
Message-ID: <20190624083000.23074-1-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This series fixes various issues reported by internal testing.
Kindly apply this series to scsi-queue at your earliest convenience.

Thanks,
~Saurav

Chad Dupuis (2):
  bnx2fc: Redo setting source FCoE MAC.
  bnx2fc: Only put reference to io_req in bnx2fc_abts_cleanup if cleanup
    times out.

Saurav Kashyap (4):
  bnx2fc: Separate out completion flags and variables for abort and
    cleanup.
  bnx2fc: Do not allow both a cleanup completion and abort completion
    for the same request.
  bnx2fc: Limit the IO size according to the FW capability.
  bnx2fc: Update the driver version to 2.12.10.

 drivers/scsi/bnx2fc/bnx2fc.h      |  14 +++--
 drivers/scsi/bnx2fc/bnx2fc_els.c  |  56 ++++++++++++------
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c |   3 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c   | 116 +++++++++++++++++++++++++++-----------
 drivers/scsi/bnx2fc/bnx2fc_tgt.c  |  10 ++--
 5 files changed, 138 insertions(+), 61 deletions(-)

-- 
1.8.3.1

