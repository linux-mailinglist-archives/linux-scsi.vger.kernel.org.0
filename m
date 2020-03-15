Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D58185B95
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Mar 2020 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgCOJmp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Mar 2020 05:42:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgCOJmp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 15 Mar 2020 05:42:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68E77AC91
        for <linux-scsi@vger.kernel.org>; Sun, 15 Mar 2020 09:42:44 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/8] scsi: Use scnprintf() for avoiding potential buffer overflow
Date:   Sun, 15 Mar 2020 10:42:33 +0100
Message-Id: <20200315094241.9086-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

here is a respin of trivial patch series just to convert suspicious
snprintf() usages with the more safer one, scnprintf().

v1->v2: Align the remaining lines to the open parenthesis


Takashi

===

Takashi Iwai (8):
  scsi: aacraid: Use scnprintf() for avoiding potential buffer overflow
  scsi: be2iscsi: Use scnprintf() for avoiding potential buffer overflow
  scsi: fnic: Use scnprintf() for avoiding potential buffer overflow
  scsi: gdth: Use scnprintf() for avoiding potential buffer overflow
  scsi: ipr: Use scnprintf() for avoiding potential buffer overflow
  scsi: megaraid_sas: Use scnprintf() for avoiding potential buffer
    overflow
  scsi: core: Use scnprintf() for avoiding potential buffer overflow
  scsi: smartpqi: Use scnprintf() for avoiding potential buffer overflow

 drivers/scsi/aacraid/linit.c              | 17 ++++-----
 drivers/scsi/be2iscsi/be_mgmt.c           | 20 +++++------
 drivers/scsi/fnic/fnic_trace.c            | 58 +++++++++++++++----------------
 drivers/scsi/gdth_proc.c                  |  2 +-
 drivers/scsi/ipr.c                        |  6 ++--
 drivers/scsi/megaraid/megaraid_sas_base.c |  7 ++--
 drivers/scsi/scsi_sysfs.c                 | 10 +++---
 drivers/scsi/smartpqi/smartpqi_init.c     | 22 ++++++------
 8 files changed, 72 insertions(+), 70 deletions(-)

-- 
2.16.4

