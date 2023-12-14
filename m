Return-Path: <linux-scsi+bounces-939-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD3812486
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 02:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90051F219CB
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81210E8;
	Thu, 14 Dec 2023 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CLQMHNkg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248BE8
	for <linux-scsi@vger.kernel.org>; Wed, 13 Dec 2023 17:25:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so1003048166b.2
        for <linux-scsi@vger.kernel.org>; Wed, 13 Dec 2023 17:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702517105; x=1703121905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHMtuMnMAbDQ3tdue8zOZbOg6oc/EvH9admOYuIg/XM=;
        b=CLQMHNkgx49CAyQjPOw+Cxufa1zazaZ2py7fEQ25e979Mvf9HqcedQYJgTo6qAzkz0
         dgFR98pe5bS+EuAKtL9kw9IK9sjnamnR8WbRqCHDeI2zfww/eMIy+aearqlEv1LNAEo2
         EMiS28vMv1yO+k0AcH0X+/T9ccGguwPL+ylQah/Ft3OYMmWFxmGTpeqRG1uzY3FEFy+I
         xcOlIYNMjAymiBEKWocjV9TPr9njW41ptuzkSBEF4wupU3uAUlmt9Z2HmIXHYSJnjDD7
         mTNhnisKrCsJMyABLVyj3/ZY++XQP1HubbAc/S71gXb4JlWIEuhc7BJOjYSxWkOT1Ux0
         1r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517105; x=1703121905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHMtuMnMAbDQ3tdue8zOZbOg6oc/EvH9admOYuIg/XM=;
        b=tZzKsHiFUrVJ5hHPgxxogbYd1vD9p4hW6jiW/rojr2in8GptoL/rWArxY2iPeQR+1b
         Lh5VK665rASvtuTPtiMEnSJBRXhN+QQeuEZPp/KUj/qYyYM6mAlRD8lv1W7CCuYE9OxH
         O3aITvaLi6STuV7GBcVCqn98O8o6NYlmXbzUuzAYe0yxveKUMopgbiMou7QES1WH811j
         Xl3p6wa16q4yYPXC8nAAqLKDYzJ7DcOWes6tTKWZems73e2p2rq9jjKAWU4XrCTwaSYN
         ZHx5ffgMJpQ4kKWeHDTpU7VPRYDg0djK6xSfj7810BSks6vgF3N9RfsnTNbkSe2ujUq4
         ZUpQ==
X-Gm-Message-State: AOJu0YyTmexqikqMP/RIe6Jd/2HBXRfjtXeOizfvd37SQEBaTIqGuug2
	9VWlX3z5qPzZz4p8GyWHg4dF+9z+AK5U3pRikndnSg==
X-Google-Smtp-Source: AGHT+IFWUSOgvKQH/lpoBb9AWGFJExhyJXNjlM/yqrWkKEXGrBGgzCmXIMqd8P1tH8OOMIxFiqgvteFOgFnaALUsdoA=
X-Received: by 2002:a17:906:739b:b0:a22:f37a:b425 with SMTP id
 f27-20020a170906739b00b00a22f37ab425mr1292007ejl.61.1702517105116; Wed, 13
 Dec 2023 17:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701540918.git.lduncan@suse.com> <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
 <ZXoOtgVZW_QpkU11@rhel-developer-toolbox-latest>
In-Reply-To: <ZXoOtgVZW_QpkU11@rhel-developer-toolbox-latest>
From: Lee Duncan <lduncan@suse.com>
Date: Wed, 13 Dec 2023 17:24:54 -0800
Message-ID: <CAPj3X_W5kOEOapG3F8NETBRzBmrQ1Lfudy7QGmCLXPT3UwUrkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
To: Chris Leech <cleech@redhat.com>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dbond@suse.com, hare@suse.de, 
	michael.christie@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies on my first reply having HTML. I'm learning a new MUA.

On Wed, Dec 13, 2023 at 12:06=E2=80=AFPM Chris Leech <cleech@redhat.com> wr=
ote:
>
> On Thu, Dec 07, 2023 at 09:42:34AM -0800, lduncan@suse.com wrote:
> > From: Lee Duncan <lduncan@suse.com>
> >
> > Some iSCSI initiators send SCSI PDUs with the "immediate" bit
> > set, and this is allowed according to RFC 3720. Commands with
> > the "Immediate" bit set are called "immediate commands". From
> > section 3.2.2.1. "Command Numbering and Acknowledging":
> >
> >    The target MUST NOT transmit a MaxCmdSN that is less than
> >    ExpCmdSN-1.  For non-immediate commands, the CmdSN field can take an=
y
> >    value from ExpCmdSN to MaxCmdSN inclusive.  The target MUST silently
> >    ignore any non-immediate command outside of this range or non-
> >    immediate duplicates within the range.  The CmdSN carried by
> >    immediate commands may lie outside the ExpCmdSN to MaxCmdSN range.
> >    For example, if the initiator has previously sent a non-immediate
> >    command carrying the CmdSN equal to MaxCmdSN, the target window is
> >    closed.  For group task management commands issued as immediate
> >    commands, CmdSN indicates the scope of the group action (e.g., on
> >    ABORT TASK SET indicates which commands are aborted).
> >
> > This fixed an issue with fastlinq qedi Converged Network Adapter
> > initiator firmware, trying to use an LIO target for booting. These
> > changes made booting possible, with or without ImmediateData enabled.
> >
> > Signed-off-by: Lee Duncan <lduncan@suse.com>
> > Reviewed-by: David Bond <dbond@suse.com>
> > ---
> >  drivers/target/iscsi/iscsi_target.c      | 12 +++---------
> >  drivers/target/iscsi/iscsi_target_util.c | 10 ++++++++--
> >  2 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi=
/iscsi_target.c
> > index 1d25e64b068a..f246e5015868 100644
> > --- a/drivers/target/iscsi/iscsi_target.c
> > +++ b/drivers/target/iscsi/iscsi_target.c
> > @@ -1060,13 +1060,6 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *co=
nn, struct iscsit_cmd *cmd,
> >                                            ISCSI_REASON_BOOKMARK_INVALI=
D, buf);
> >       }
> >
> > -     if (hdr->opcode & ISCSI_OP_IMMEDIATE) {
> > -             pr_err("Illegally set Immediate Bit in iSCSI Initiator"
> > -                             " Scsi Command PDU.\n");
> > -             return iscsit_add_reject_cmd(cmd,
> > -                                          ISCSI_REASON_BOOKMARK_INVALI=
D, buf);
> > -     }
> > -
> >       if (payload_length && !conn->sess->sess_ops->ImmediateData) {
> >               pr_err("ImmediateData=3DNo but DataSegmentLength=3D%u,"
> >                       " protocol error.\n", payload_length);
>
> This seems right, as the flag is checked again later in the same
> function.
>
> > @@ -1255,14 +1248,15 @@ int iscsit_process_scsi_cmd(struct iscsit_conn =
*conn, struct iscsit_cmd *cmd,
> >       /*
> >        * Check the CmdSN against ExpCmdSN/MaxCmdSN here if
> >        * the Immediate Bit is not set, and no Immediate
> > -      * Data is attached.
> > +      * Data is attached. Also skip the check if this is
> > +      * an immediate command.
>
> This comment addition seems redundant, isn't that what the "Immediate
> Bit is not set" already means?

The spec is confusing with respect to this. The "Immediate Bit"
means an immediate command. These commands are done "now",
not queued, and they do not increment the expected sequence number.

Immediate data is different, and unfortunately named IMHO. It's when a
PDU supplies the data for the SCSI command in the current PDU instead
of the next PDU.

>
> >        *
> >        * A PDU/CmdSN carrying Immediate Data can only
> >        * be processed after the DataCRC has passed.
> >        * If the DataCRC fails, the CmdSN MUST NOT
> >        * be acknowledged. (See below)
> >        */
> > -     if (!cmd->immediate_data) {
> > +     if (!cmd->immediate_data && !cmd->immediate_cmd) {
> >               cmdsn_ret =3D iscsit_sequence_cmd(conn, cmd,
> >                                       (unsigned char *)hdr, hdr->cmdsn)=
;
> >               if (cmdsn_ret =3D=3D CMDSN_ERROR_CANNOT_RECOVER)
>
> Are you sure this needs to be checking both conditions here?  I'm
> struggling to understand why CmdSN checking would be bypassed for
> immediate data.  Is this a longstanding bug where the condition should
> have been on immediate_cmd (and only immediate_cmd) instead?

The immediate data check was there already, and there haven't been any
bugs I know of, so I assumed that part of the code was ok.

>
> Or is this because of the handling the immediate data with DataCRC case
> mentioned?  I do see iscsit_sequence_cmd also being called in
> iscsit_get_immediate_data.

I will check that but I suspect you are correct.

>
> - Chris Leech
>

