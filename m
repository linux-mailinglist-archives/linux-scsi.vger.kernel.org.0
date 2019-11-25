Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70A6109230
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Nov 2019 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfKYQv6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Nov 2019 11:51:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfKYQv5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 25 Nov 2019 11:51:57 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B3F7328FCBE;
        Mon, 25 Nov 2019 16:51:56 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        open-iscsi@googlegroups.com, kernel@collabora.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] iscsi: Don't send data to unbinded connection
Organization: Collabora
References: <20191116004735.16860-1-krisman@collabora.com>
        <yq136ekifn0.fsf@oracle.com>
Date:   Mon, 25 Nov 2019 11:51:53 -0500
In-Reply-To: <yq136ekifn0.fsf@oracle.com> (Martin K. Petersen's message of
        "Tue, 19 Nov 2019 00:44:51 -0500")
Message-ID: <85h82rvqza.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

"Martin K. Petersen" <martin.petersen@oracle.com> writes:

> Applied to 5.5/scsi-queue. But please make sure to send patch
> submissions to linux-scsi@vger.kernel.org.

Hi Martin,

Thanks for applying them.  My apologies for not CC'ing
linux-scsi, I will be sending more fixes like this to iSCSI and I will
make sure to CC the right list in the future.

Although, looks like the MAINTAINERS file doesn't list linux-scsi as the
target for iscsi patches.  Would you take the fix below to address that?

Thanks,

-- >8 --
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] MAINTAINERS: Add the linux-scsi mailing list to the ISCSI entry


Most people who review iSCSI are following linux-scsi, but some are not
in open-scsi.  Make sure we are routing iSCSI patches to the right list.

There are precedents in the MAINTAINERS file for subsystems pointing to
two mailing lists, so this shouldn't be a problem, but maybe we want to
drop the open-iscsi reference?

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3bbb1784913..a0ddc7f4ec1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8668,6 +8668,7 @@ ISCSI
 M:	Lee Duncan <lduncan@suse.com>
 M:	Chris Leech <cleech@redhat.com>
 L:	open-iscsi@googlegroups.com
+L:	linux-scsi@vger.kernel.org
 W:	www.open-iscsi.com
 S:	Maintained
 F:	drivers/scsi/*iscsi*
-- 
2.24.0


