Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA986F0117
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfKEPUe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Nov 2019 10:20:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37332 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388844AbfKEPUd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Nov 2019 10:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572967233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRRzs30XjRipND2j6Nm1AIpwVKhtbjW4JnAYuedA/U4=;
        b=Qoqo7BrVmud0DRgZQoWsFVyJhk0tnG5NvqNgB02MlsJlwh4ydaZVFGExXr4WGZAkYT8Ufw
        L2t7rQBp422klLVkuDQa4jiZItoWLmYGpulu0W9/pZ4uLnf4BDiPCGRLkAc+CyWaijKg1t
        fNIoO96XfmaeNmfh6UEOpHsSXX0e/BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-eTyZZnyVP2mjOm5yvwlGew-1; Tue, 05 Nov 2019 10:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDC421800D4A;
        Tue,  5 Nov 2019 15:20:28 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD0C60BF4;
        Tue,  5 Nov 2019 15:20:28 +0000 (UTC)
Message-ID: <eabc6e952437d22a36e2b8eab0be499c8c468fe8.camel@redhat.com>
Subject: Re: [PATCH 6/8] qla2xxx: Fix memory leak when sending I/O fails
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Tue, 05 Nov 2019 10:20:27 -0500
In-Reply-To: <20191105150657.8092-7-hmadhani@marvell.com>
References: <20191105150657.8092-1-hmadhani@marvell.com>
         <20191105150657.8092-7-hmadhani@marvell.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eTyZZnyVP2mjOm5yvwlGew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-11-05 at 07:06 -0800, Himanshu Madhani wrote:
> From: Arun Easi <aeasi@marvell.com>
>=20
> On heavy loads, a memory leak of the srb_t structure is observed.
> This would make the qla2xxx_srbs cache gobble up memory.
>=20
> Fixes: 219d27d7147e0 ("scsi: qla2xxx: Fix race conditions in the code for=
 aborting SCSI commands")
> Cc: stable@vger.kernel.org # 5.2
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
> index b59d579834ea..b513008042fb 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -909,6 +909,8 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct s=
csi_cmnd *cmd)
> =20
>  qc24_host_busy_free_sp:
>  =09sp->free(sp);
> +=09CMD_SP(cmd) =3D NULL;
> +=09qla2x00_rel_sp(sp);
> =20
>  qc24_target_busy:
>  =09return SCSI_MLQUEUE_TARGET_BUSY;
> @@ -992,6 +994,8 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct =
scsi_cmnd *cmd,
> =20
>  qc24_host_busy_free_sp:
>  =09sp->free(sp);
> +=09CMD_SP(cmd) =3D NULL;
> +=09qla2xxx_rel_qpair_sp(sp->qpair, sp);
> =20
>  qc24_target_busy:
>  =09return SCSI_MLQUEUE_TARGET_BUSY;

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

