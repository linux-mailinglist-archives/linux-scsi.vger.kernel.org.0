Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92B1D25A1
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2020 06:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgENEBz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 May 2020 00:01:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49759 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725876AbgENEBz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 May 2020 00:01:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-aP7_It_xNvmGipQcRGESVw-1; Thu, 14 May 2020 00:01:50 -0400
X-MC-Unique: aP7_It_xNvmGipQcRGESVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDEC819200C0;
        Thu, 14 May 2020 04:01:49 +0000 (UTC)
Received: from ldigby.remote.csb (vpn2-54-19.bne.redhat.com [10.64.54.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 710CF2E169;
        Thu, 14 May 2020 04:01:48 +0000 (UTC)
From:   Lance Digby <lance.digby@gmail.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH target] target: Add initiatorname to NON_EXISTENT_LUN error
Date:   Thu, 14 May 2020 14:01:38 +1000
Message-Id: <cd119ce943d9ec62ef1bff237ebb49e35a337c3b.1589407872.git.lance.digby@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The NON_EXISTENT_LUN error can be written without an error condition
 on the initiator responsible. Adding the initiatorname to this message
 will reduce the effort required to fix this when many initiators are
supported by a target.

Signed-off-by: Lance Digby <lance.digby@gmail.com>
---
 drivers/target/target_core_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_co=
re_device.c
index 4cee113..604dea0 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -100,9 +100,10 @@
 =09=09 */
 =09=09if (unpacked_lun !=3D 0) {
 =09=09=09pr_err("TARGET_CORE[%s]: Detected NON_EXISTENT_LUN"
-=09=09=09=09" Access for 0x%08llx\n",
+=09=09=09=09" Access for 0x%08llx from %s\n",
 =09=09=09=09se_cmd->se_tfo->fabric_name,
-=09=09=09=09unpacked_lun);
+=09=09=09=09unpacked_lun,
+=09=09=09=09se_sess->se_node_acl->initiatorname);
 =09=09=09return TCM_NON_EXISTENT_LUN;
 =09=09}
=20
--=20
1.8.3.1

