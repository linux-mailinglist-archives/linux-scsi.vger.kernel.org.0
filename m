Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92A4299BB
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Oct 2021 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhJKXRf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Oct 2021 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhJKXRf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Oct 2021 19:17:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CF4C061570
        for <linux-scsi@vger.kernel.org>; Mon, 11 Oct 2021 16:15:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n64so26718548oih.2
        for <linux-scsi@vger.kernel.org>; Mon, 11 Oct 2021 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:mime-version:content-disposition;
        bh=vi+Xh9GBXjNufwxtFJrxL9/JrA3l4jmkAmqg2MJ3Qm4=;
        b=YQ7669i5zh+8UyXfv9Xdw/kkLzkkFs6tEKl163nF9x745HYZN+QKIoWKg4PaBFBOnm
         B1Yr88ACZ/mV0b8MyarPvLjdBGgA6TRRSXQSdZO1SQ8M/fOlUmJq4czULO8Ek159ecfM
         mpQBDeKwHM2U1q/myDxGpnXfM5idZ6db76WMUlB0wB1LDhLJPXCwdchys69J6FjHULxF
         rAeZZmil26Uww2qW5HAZOViIe/fVLQ17HLpR+RBVBRGslAOhyFFeudi2Latun3RNyDpC
         aI18sHd+qg1iccxRd9mFoQsGoXMpZvUTFF+ro/ugiJStKfrl9gyWZ3jZ0mgODX56+pI1
         2AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition;
        bh=vi+Xh9GBXjNufwxtFJrxL9/JrA3l4jmkAmqg2MJ3Qm4=;
        b=2dDKG+aU+ajmGk8s4rqYiKze6Q2i4RXuF7rHHWRfM5mrtIXKGCwWRg0QGIyIWbDNdC
         0hqNOZV43RmLJ/la4RYbObUSs0T5Me4hJrBrdDVprMqlaRu+JHYUU/wXxbXYOuYwsEoQ
         6Yx+NLq9iL7vCSxDrxIk6UhhXKiM1s4idBRhXt0m1mui4SQlQFvLcWgXnBTPCHMxqG1c
         MU+KLKlJ58JxOKX3tQmJASZTwWu4dPPAOBSgW08EDCZy3+XUROR1sVOz7upfE+uE2sKb
         bK+fAd3ANxcJhDDGdOrKTQ4/hUraXT6xq3vw82kxNhJzZmRS+ZFv593EZqodPZwr+0zW
         hZtQ==
X-Gm-Message-State: AOAM532P/mM1rxffbnf/Kj0sjBxe6HyL43tIaQLst8RPizMtuzZaVcKp
        R/8ze0ArAsvr+MQPtL0Lw7xBjcl3jQj3ZAt9
X-Google-Smtp-Source: ABdhPJwf+tMsrvQejJ37HsfSqaItUe26HkEUc6MlsqP6KJrRergZlxd1OALNwB9rSYygA14iWZlriA==
X-Received: by 2002:aca:aa42:: with SMTP id t63mr1376797oie.118.1633994133472;
        Mon, 11 Oct 2021 16:15:33 -0700 (PDT)
Received: from t ([2600:1700:4b80:20d0::31])
        by smtp.gmail.com with ESMTPSA id i24sm1967967oie.42.2021.10.11.16.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:15:33 -0700 (PDT)
Date:   Mon, 11 Oct 2021 19:15:30 -0400
From:   docfate111 <tdwilliamsiv@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com
Message-ID: <20211011231530.GA22856@t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

linux-scsi@vger.kernel.org,
linux-kernel@vger.kernel.org,
martin.petersen@oracle.com
Bcc: 
Subject: [PATCH] scsi_lib fix the NULL pointer dereference
Reply-To: 

scsi_setup_scsi_cmnd should check for the pointer before
scsi_command_size dereferences it.

Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 572673873ddf..9abaacd6db67 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1174,7 +1174,7 @@ static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
 	}
 
 	cmd->cmd_len = scsi_req(req)->cmd_len;
-	if (cmd->cmd_len == 0)
+	if (cmd->cmd_len == 0 && cmd->cmnd)
 		cmd->cmd_len = scsi_command_size(cmd->cmnd);
 	cmd->cmnd = scsi_req(req)->cmd;
 	cmd->transfersize = blk_rq_bytes(req);
-- 
2.25.1

