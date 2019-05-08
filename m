Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5A1812B
	for <lists+linux-scsi@lfdr.de>; Wed,  8 May 2019 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEHUks (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 May 2019 16:40:48 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:45743 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfEHUkr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 May 2019 16:40:47 -0400
Received: by mail-yw1-f41.google.com with SMTP id w18so11140ywa.12
        for <linux-scsi@vger.kernel.org>; Wed, 08 May 2019 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quadstor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=IRLgqr7G6M5oNo5Sn5vI/dABACGqET6tzlr6b1OSoYQ=;
        b=nsIhTDy5fFoR5ybyISoreJYb0QVwhk348U6WjWUfoMOKMXqpaMhRlZ0dVVARU57ywH
         jFB3cda0RYxEYdoELXXVUKbdzFGVbqIzuyZm/q2VlU0Z2Auus57daaE7tS3OqSvqB0bo
         nkjqluE/a8HKo0Vzjybda85b0PUuIOMPSSIcXoQKFsskPjVxfReZCopZa7F6pOYNyiu8
         +90QR71m9lmisvLF/6ZZuzyVkmO654z2sUpSClM8aGn5LaVSegFX3l3jhWLaHdGBzudz
         XarF9WNhjAICZSIujE2+J2ANMeLKU5VJXbR9RLK4f9bzZ4QIi2ZEUykuqss5Yxf+B/yy
         eZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IRLgqr7G6M5oNo5Sn5vI/dABACGqET6tzlr6b1OSoYQ=;
        b=QV8HmZY4vrWWuvO3VxAlFsaCs8O1SewTLB7IwEFcXDkb6AXzaZiejtcemcG6Zksnbo
         nsVkoZ3l/cg/Wzz+QClhQ9Ao+Bx5+ke+3tGG8hTCitfZvaMAiQ324cmr044zhzWT2LB+
         ggT26X+Fx5RrJvjon4iqJGmDK1y4FRTqiobVC6+2Hw3dpITnn/Q4TQGUHDl684d/eSjr
         B+GVb1yUJf8Dh58plM+eRTGK8N9CgPT8g1uWMpv2Sk1P5ITtWACPUyEXmR4O+BA6avej
         NclHQw2EnReE+xH52OwTsZ1dAQpyjiDmCSGCLD2mbb8WVgv93kYj6uAIYFf/JxKLrCKT
         hc/w==
X-Gm-Message-State: APjAAAVRk4W86BzL8axE2UqLOp9/y+MN3pWDIbAy0Z8yqfuN+ngM8uBM
        bR6SPZTS7sNsaqVuLqozpS3Pp3/VvC+pjLjXFsYJUHxsvuA=
X-Google-Smtp-Source: APXvYqwd/qWJ0pDnfJeCbauNXCx5yILZjRrkoPUFZGrp+M5VHFp7ax9GHFAfHcZ86c4SWVNmD8ZiyENmgeb2vcsgC+M=
X-Received: by 2002:a25:690d:: with SMTP id e13mr40353ybc.178.1557348046359;
 Wed, 08 May 2019 13:40:46 -0700 (PDT)
MIME-Version: 1.0
From:   Shivaram Upadhyayula <shivaram.u@quadstor.com>
Date:   Thu, 9 May 2019 02:10:35 +0530
Message-ID: <CAN-_EfwKNP5bK-ew7d+T4k8V3faOeFpR8-s_k6PGECSUFoMH9w@mail.gmail.com>
Subject: Problems with logout in qlt_free_session_done
To:     linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

There seem to be a few issues when trying to do a logout
qla_target.c:qlt_free_session_done in 4.19.41

1. When the logout timesout qla2x00_sp_timeout is called. This
function assumes sp->qpair is valid, but this isn't the case if mq is
not enabled

2. qla2x00_async_iocb_timeout also assumes that sp->qpair is valid.
Also only if qla24xx_async_abort_cmd() fails is sp->done() called,
sp->done in this case is qlt_logo_completion_handler() which will
never be called if qla24xx_async_abort_cmd() succeeds

3. qla24xx_async_abort_cmd() can lead to "scheduling while atomic" if
called from qla2x00_async_iocb_timeout. The wait parameter can be used
to alloc with GFP_ATOMIC

Please see diff https://www.quadstor.com/patches/srb-logout.diff
generated against 4.9.41

Regards,
Shivaram

-- 
Virtual Tape Library https://www.quadstor.com/virtual-tape-library.html
Storage Virtualization with VAAI
https://www.quadstor.com/storage-virtualization.html
