Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C15168B14
	for <lists+linux-scsi@lfdr.de>; Sat, 22 Feb 2020 01:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBVAit (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Feb 2020 19:38:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1471 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgBVAit (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Feb 2020 19:38:49 -0500
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Feb 2020 16:38:48 -0800
Received: from asutoshd-linux1.qualcomm.com ([10.46.160.39])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 21 Feb 2020 16:38:48 -0800
Received: by asutoshd-linux1.qualcomm.com (Postfix, from userid 92687)
        id E0C1D216F9; Fri, 21 Feb 2020 16:38:47 -0800 (PST)
From:   Asutosh Das <asutoshd@codeaurora.org>
To:     asutoshd@qti.qualcomm.com, linux-scsi@vger.kernel.org
Subject: [<RFC PATCH v1> 0/2] Write Booster Implementation 
Date:   Fri, 21 Feb 2020 16:38:45 -0800
Message-Id: <cover.1582330473.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Write Booster has been added to UFS-3.1 specification-Section-13.4.17
This is a RFC implementation of the same.


Asutosh Das (2):
  scsi: ufs: add write booster feature support
  ufs-qcom: scsi: configure write booster type

 drivers/scsi/ufs/ufs-qcom.c  |   7 ++
 drivers/scsi/ufs/ufs-sysfs.c |  41 ++++++-
 drivers/scsi/ufs/ufs.h       |  61 ++++++++-
 drivers/scsi/ufs/ufshcd.c    | 286 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.h    |   9 ++
 5 files changed, 397 insertions(+), 7 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

