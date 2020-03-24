Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9741906D7
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Mar 2020 08:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCXHxR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Mar 2020 03:53:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbgCXHxR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 24 Mar 2020 03:53:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA77646081E544C8350C;
        Tue, 24 Mar 2020 15:53:00 +0800 (CST)
Received: from [10.173.221.252] (10.173.221.252) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 15:52:50 +0800
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Subject: PATCH] iscsi:report unbind session event when the target has been
 removed
Message-ID: <4eab1771-2cb3-8e79-b31c-923652340e99@huawei.com>
Date:   Tue, 24 Mar 2020 15:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.173.221.252]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The daemon is restarted or crashed while logging out of a session.
The unbind session event sent by the kernel is not be processed or be lost.
When the daemon runs again, the session will never be able to logout.

After executing the logout again, the daemon is waiting for the unbind 
event message.
The kernel status has been logged out and the event will not be sent again.

#iscsiadm -m node iqn.xxx -p xx.xx.xx.xx -u &
#service iscsid restart

when iscsid restart done. logout session again report error:
#iscsiadm -m node iqn.xxxxx -p xx.xx.xx.xx -u
Logging out of session [sid: 6, target: iqn.xxxxx, portal: xx.xx.xx.xx,3260]
iscsiadm: Could not logout of [sid: 6, target: iscsiadm -m node 
iqn.xxxxx, portal: xx.xx.xx.xx,3260].
iscsiadm: initiator reported error (9 - internal error)
iscsiadm: Could not logout of all requested sessions

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
  drivers/scsi/scsi_transport_iscsi.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c 
b/drivers/scsi/scsi_transport_iscsi.c
index dfc726f..443ace0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2012,7 +2012,7 @@ static void __iscsi_unbind_session(struct 
work_struct *work)
         if (session->target_id == ISCSI_MAX_TARGET) {
                 spin_unlock_irqrestore(&session->lock, flags);
                 mutex_unlock(&ihost->mutex);
-               return;
+               goto unbind_session_exit;
         }

         target_id = session->target_id;
@@ -2024,6 +2024,8 @@ static void __iscsi_unbind_session(struct 
work_struct *work)
                 ida_simple_remove(&iscsi_sess_ida, target_id);

         scsi_remove_target(&session->dev);
+
+unbind_session_exit:
         iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
         ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
  }
--
1.8.3.1

