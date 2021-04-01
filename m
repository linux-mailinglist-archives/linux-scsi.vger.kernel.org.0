Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4832F350EE5
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Apr 2021 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhDAGP1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Apr 2021 02:15:27 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:38087 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhDAGPF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Apr 2021 02:15:05 -0400
IronPort-SDR: c1JBpeuXGIo5PFSxWsYHS1SSQYx74ja1WwdCrpfHiF5u8HFZzzKb+X8pdQJ3TVoQV+V8dstOGF
 NED57/Omqi8AnjBzDQtG2Sovi9zk/PkrSQhi9Yac1oiZb1xEuGvzkYWC8h99NjiXt9ESoMuxHb
 rB9nLRdssrbu82IoOKNRSd3JbfwL+4nV0XH4XEKOvlsl1VQ2S6/bfnnd4VyjDwXVzOmpjRtZXT
 hlDk6UA1ubFf8HWkQNrFRfZUIGdRzGBayx0UdrhTjHsbXOOVC07EJy2QFtpa7GOAtEFNmYFr8n
 RIM=
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="29736605"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 31 Mar 2021 23:15:06 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg01-sd.qualcomm.com with ESMTP; 31 Mar 2021 23:15:04 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 3855C210A9; Wed, 31 Mar 2021 23:15:04 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Subject: [PATCH v4 0/2] Introduce hba performance monitoring sysfs nodes
Date:   Wed, 31 Mar 2021 23:15:01 -0700
Message-Id: <1617257704-1154-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a new sysfs group which has nodes to monitor data/request transfer
performance. This sysfs group has nodes showing total sectors/requests
transferred, total busy time spent and max/min/avg/sum latencies. This
group can be enhanced later to show more UFS driver layer performance
data during runtime.

It works like:
/sys/bus/platform/drivers/ufshcd/*/monitor # echo 4096 > monitor_chunk_size
/sys/bus/platform/drivers/ufshcd/*/monitor # echo 1 > monitor_enable
/sys/bus/platform/drivers/ufshcd/*/monitor # grep ^ /dev/null *
monitor_chunk_size:4096
monitor_enable:1
read_nr_requests:17
read_req_latency_avg:169
read_req_latency_max:594
read_req_latency_min:66
read_req_latency_sum:2887
read_total_busy:2639
read_total_sectors:136
write_nr_requests:116
write_req_latency_avg:440
write_req_latency_max:4921
write_req_latency_min:23
write_req_latency_sum:51052
write_total_busy:19584
write_total_sectors:928

Change since v3:
- Rebased

Change since v2:
- Fixed a sparse error

Change since v1:
- Moved code from ufs-qcom.c to ufshcd.c

Can Guo (2):
  scsi: ufs: Introduce hba performance monitor sysfs nodes
  scsi: ufs: Add support for hba performance monitor

 Documentation/ABI/testing/sysfs-driver-ufs | 126 +++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 237 +++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                  |  62 ++++++++
 drivers/scsi/ufs/ufshcd.h                  |  21 +++
 4 files changed, 446 insertions(+)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

