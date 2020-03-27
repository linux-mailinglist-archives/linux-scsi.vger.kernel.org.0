Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167BF195535
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgC0K1f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Mar 2020 06:27:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51068 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgC0K1f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Mar 2020 06:27:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RAPrkc005388;
        Fri, 27 Mar 2020 03:27:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=iNN+tbqz9Wh+7HUgSGo3vlBQYSZ5DnFrOrYElYw9Fr8=;
 b=nbjqBZikS1mHkj3z8btvFi7AZ/1uj1P6PLOLpkfC6pUoLqsk9QnidH0YmMoVRxz8OEsx
 IBBQRWM0uSMIyv8fcGWrVC02CeZ62qCutBletNK1NSh4GRORUfpL3t5tah+ps71Fhw91
 xBuPnEn06+C0qWHwONi46CA7/NhT6HCsStpsd+ObALoeVrIYhlVYP8osKf2SLwDEJ/nC
 IJh8dttIGdjJ/K3sbVBTNhtdkJu1nhvXvo77w+cb7G05vy7r6kWY4dQy1zmtkOPH5B7c
 l6DMunDZVhgi8euEFfaj6cEx3vWB7qC1QcVXVu51OwSVmCyqV1FRM1GNdksx2m523r5Q 9A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 300bpd0n8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 03:27:32 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Mar
 2020 03:27:31 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Mar 2020 03:27:30 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id E519D3F703F;
        Fri, 27 Mar 2020 03:27:30 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 02RARURr022386;
        Fri, 27 Mar 2020 03:27:30 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 02RARU1a022385;
        Fri, 27 Mar 2020 03:27:30 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>, <emilne@redhat.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 0/3] qla2xxx: Updates for the driver
Date:   Fri, 27 Mar 2020 03:27:27 -0700
Message-ID: <20200327102730.22351-1-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_03:2020-03-27,2020-03-27 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

Please apply the qla2xxx driver bug fixes to the scsi tree at your earliest
convenience.

Thanks,
Nilesh

Arun Easi (2):
  qla2xxx: Fix MPI failure AEN (8200) handling.
  qla2xxx: Fix hang when issuing nvme disconnect-all in NPIV.

Quinn Tran (1):
  qla2xxx: delete all sessions before unregister local nvme port

 drivers/scsi/qla2xxx/qla_attr.c |  32 +++++++--
 drivers/scsi/qla2xxx/qla_def.h  |  13 +++-
 drivers/scsi/qla2xxx/qla_gbl.h  |   3 +
 drivers/scsi/qla2xxx/qla_init.c |   2 +
 drivers/scsi/qla2xxx/qla_isr.c  |  54 ++++++++++-----
 drivers/scsi/qla2xxx/qla_mbx.c  |   2 +-
 drivers/scsi/qla2xxx/qla_os.c   |   6 ++
 drivers/scsi/qla2xxx/qla_tmpl.c | 118 ++++++++++++++++++++++++++------
 8 files changed, 187 insertions(+), 43 deletions(-)

-- 
2.19.0.rc0

