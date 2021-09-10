Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6024064F5
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 03:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhIJBNa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 21:13:30 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:15874 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhIJBM6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Sep 2021 21:12:58 -0400
Received: from localhost.localdomain (unknown [113.116.176.115])
        by mail-m17642.qiye.163.com (Hmail) with ESMTPA id E007C2200D9;
        Fri, 10 Sep 2021 09:02:58 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, michael.christie@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ding Hui <dinghui@sangfor.com.cn>
Subject: [RESEND] [PATCH 0/3] fix several bugs about libiscsi
Date:   Fri, 10 Sep 2021 09:02:17 +0800
Message-Id: <20210910010220.24073-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpCQx1WHU9LS0lNQk9DSk
        9KVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Dxw5Tz4LHh5RLS4jSEsW
        S0IKCUJVSlVKTUhKSUhOTExCTkpMVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVSkpNVUpMTVVKSk5ZV1kIAVlBSklOQjcG
X-HM-Tid: 0a7bcd3aaa6ad998kuwse007c2200d9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Ding Hui (3):
  scsi: libiscsi: move init ehwait to iscsi_session_setup()
  scsi: libiscsi: fix invalid pointer dereference in
    iscsi_eh_session_reset
  scsi: libiscsi: get ref to conn in iscsi_eh_device/target_reset()

 drivers/scsi/libiscsi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.17.1

