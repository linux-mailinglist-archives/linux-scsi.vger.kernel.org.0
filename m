Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B32F2B6B
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405966AbhALJfJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 04:35:09 -0500
Received: from comms.puri.sm ([159.203.221.185]:33642 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbhALJfJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Jan 2021 04:35:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D76FDDF42D;
        Tue, 12 Jan 2021 01:33:58 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YD_EqG3nAla5; Tue, 12 Jan 2021 01:33:58 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        stern@rowland.harvard.edu, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 3/3] scsi: sd: Documentation: describe ignore_resume_medium_changed
Date:   Tue, 12 Jan 2021 10:33:29 +0100
Message-Id: <20210112093329.3639-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210112093329.3639-1-martin.kepplinger@puri.sm>
References: <20210112093329.3639-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add notes about the new sd sysfs knob that works around problems
with runtime PM for certain types of SD cardreaders.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/scsi/sd-parameters.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/scsi/sd-parameters.rst b/Documentation/scsi/sd-parameters.rst
index 87d554008bfb..a77b9fdffddf 100644
--- a/Documentation/scsi/sd-parameters.rst
+++ b/Documentation/scsi/sd-parameters.rst
@@ -25,3 +25,17 @@ To modify the caching mode without making the change persistent, prepend
 "temporary " to the cache type string. E.g.::
 
   # echo "temporary write back" > cache_type
+
+ignore_resume_medium_changed (RW)
+---------------------------------
+Some SD cardreaders deliver a "media changed" unit attention (that results
+in I/O error) when they are resumed from suspend. This prevents users
+to use runtime PM with these devices. To enable runtime PM for an SD
+cardreader (here, device number 0:0:0:0), do something like:
+
+echo 0 > /sys/module/block/parameters/events_dfl_poll_msecs
+echo 1000 > /sys/bus/scsi/devices/0:0:0:0/power/autosuspend_delay_ms
+echo auto > /sys/bus/scsi/devices/0:0:0:0/power/control
+
+And if using the mounted disk filesystem causes trouble, try setting
+ignore_resume_medium_changed to 1.
-- 
2.20.1

