Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE122997E2
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgJZUYR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 16:24:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37310 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731368AbgJZUYQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Oct 2020 16:24:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id m22so9203514ots.4
        for <linux-scsi@vger.kernel.org>; Mon, 26 Oct 2020 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=c9+EsDPLBsDb8A/eh3gwy4mcNCh6pKrfuBauzOBGGjA=;
        b=Vy3CM2STMTeI4uhPZfTX2o/qGxlXdLWNF2GSvv7CI1zFwyuI/rQ6grf8PFsnN3EGRj
         fBkbo5cGN45doHmJCt3D0d9FocRzsnxOqZpqg2Nym6UiqREcMhkA/VQZ0t5rBUe50GUv
         q87Eif6z2QUCXZhmwh16034zN6RhtxwZt4H3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=c9+EsDPLBsDb8A/eh3gwy4mcNCh6pKrfuBauzOBGGjA=;
        b=OMnKfpIr3V5ZY5WWvcsJeogzNXEYLEG7p8B6ELT7ta9cETE/xXOUWmXZGvauuZRpQ4
         0+U60kVOVFd0azFl2jQrcyj6xFkgXv3Mx6Xjkb3X+OX8iV7pGDf/mn2MCNUrW+NSpeW9
         iD5kdAYrz3Pb7BoFFsaiaE3YWBdm1mCyBDDSK7AhuRBejO+8Cftu60TINQFcy31F+o8L
         a5zo9zRpeT2+8k/uIM8tUtAk76oUAt02PqcWx76paMLY5eGQTQ0ZxMXYNlgRcKb775Mw
         KR9nSymZeDW7uG4LrV/09+D5nf3LNR9Pniz/rPiHJvJKAgQ/ssx6Pg2D7jsUJslNgH6/
         FarQ==
X-Gm-Message-State: AOAM532PFRL/Vt6iYe27KidzBDlhcokEFwLnZ2fB6mn/5wZzjEnyxc75
        5rcNQSxl+lrLOsepQwOEKuD7cmJzsYvm4dgnWLbLIA==
X-Google-Smtp-Source: ABdhPJyouRRZcaWx0IB7qiNsKqSPme0PzDJpus01R+Yzdsb6Bx5akaM5/ows6BUKxkyRtJMV1Nb0wTKeTUUEfPTA6co=
X-Received: by 2002:a9d:3f44:: with SMTP id m62mr16695659otc.364.1603743854896;
 Mon, 26 Oct 2020 13:24:14 -0700 (PDT)
From:   Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <1603370091-9337-1-git-send-email-muneendra.kumar@broadcom.com>
         <1603370091-9337-5-git-send-email-muneendra.kumar@broadcom.com> <e067dd48cbc1b0d09032c7b449a4f5d6802bac1b.camel@redhat.com>
In-Reply-To: <e067dd48cbc1b0d09032c7b449a4f5d6802bac1b.camel@redhat.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLv5vf0y45oXVLFrswKM5p1yAny/wICmmMsA1RCFDynTSbT8A==
Date:   Tue, 27 Oct 2020 01:54:12 +0530
Message-ID: <336c3bb85208d79e64439b08606a507b@mail.gmail.com>
Subject: RE: [patch v4 4/5] scsi_transport_fc: Added a new rport state FC_PORTSTATE_MARGINAL
To:     "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        michael.christie@oracle.com, hare@suse.de
Cc:     jsmart2021@gmail.com, mkumar@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ce163f05b298b670"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000ce163f05b298b670
Content-Type: text/plain; charset="UTF-8"

Hi ewan,
Thanks for the input.
I will change this.

Regards,
Muneendra.

-----Original Message-----
From: Ewan D. Milne [mailto:emilne@redhat.com]
Sent: Monday, October 26, 2020 5:18 PM
To: Muneendra <muneendra.kumar@broadcom.com>; linux-scsi@vger.kernel.org;
michael.christie@oracle.com; hare@suse.de
Cc: jsmart2021@gmail.com; mkumar@redhat.com
Subject: Re: [patch v4 4/5] scsi_transport_fc: Added a new rport state
FC_PORTSTATE_MARGINAL

See below.  I think you wanted to check for FC_PORTSTATE_MARGINAL in the
code you added to fc_scsi_scan_rport().  Instead the code tests for
FC_PORTSTATE_ONLINE twice.

-Ewan

On Thu, 2020-10-22 at 18:04 +0530, Muneendra wrote:
> Added a new rport state FC_PORTSTATE_MARGINAL.
>
> Added a new inline function fc_rport_chkmarginal_set_noretries
> which will set the SCMD_NORETRIES_ABORT bit in cmd->state if rport
> state is marginal.
>
> Made changes in fc_eh_timed_out to call
> fc_rport_chkmarginal_set_noretries
> Also made changes in fc_remote_port_delete,fc_user_scan_tgt,
> fc_timeout_deleted_rport functions  to handle the new rport state
> FC_PORTSTATE_MARGINAL.
>
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
>
> ---
> v4:
> Made changes in fc_eh_timed_out to call
> fc_rport_chkmarginal_set_noretries
> so that SCMD_NORETRIES_ABORT bit in cmd->state is set if rport state
> is marginal.
>
> Removed the newly added scsi_cmd argument to fc_remote_port_chkready
> as the current patch handles only SCSI EH timeout/abort case.
>
> v3:
> Rearranged the patch so that all the changes with respect to new rport
> state is part of this patch.
> Added a new argument to scsi_cmd  to fc_remote_port_chkready
>
> v2:
> New patch
> ---
>  drivers/scsi/scsi_transport_fc.c | 41 +++++++++++++++++++-----------
> --
>  include/scsi/scsi_transport_fc.h | 19 +++++++++++++++
>  2 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/scsi/scsi_transport_fc.c
> b/drivers/scsi/scsi_transport_fc.c
> index 2ff7f06203da..fcb38068e2a4 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -142,20 +142,23 @@ fc_enum_name_search(host_event_code,
> fc_host_event_code,
>  static struct {
>  	enum fc_port_state	value;
>  	char			*name;
> +	int			matchlen;
>  } fc_port_state_names[] = {
> -	{ FC_PORTSTATE_UNKNOWN,		"Unknown" },
> -	{ FC_PORTSTATE_NOTPRESENT,	"Not Present" },
> -	{ FC_PORTSTATE_ONLINE,		"Online" },
> -	{ FC_PORTSTATE_OFFLINE,		"Offline" },
> -	{ FC_PORTSTATE_BLOCKED,		"Blocked" },
> -	{ FC_PORTSTATE_BYPASSED,	"Bypassed" },
> -	{ FC_PORTSTATE_DIAGNOSTICS,	"Diagnostics" },
> -	{ FC_PORTSTATE_LINKDOWN,	"Linkdown" },
> -	{ FC_PORTSTATE_ERROR,		"Error" },
> -	{ FC_PORTSTATE_LOOPBACK,	"Loopback" },
> -	{ FC_PORTSTATE_DELETED,		"Deleted" },
> +	{ FC_PORTSTATE_UNKNOWN,		"Unknown", 7},
> +	{ FC_PORTSTATE_NOTPRESENT,	"Not Present", 11 },
> +	{ FC_PORTSTATE_ONLINE,		"Online", 6 },
> +	{ FC_PORTSTATE_OFFLINE,		"Offline", 7 },
> +	{ FC_PORTSTATE_BLOCKED,		"Blocked", 7 },
> +	{ FC_PORTSTATE_BYPASSED,	"Bypassed", 8 },
> +	{ FC_PORTSTATE_DIAGNOSTICS,	"Diagnostics", 11 },
> +	{ FC_PORTSTATE_LINKDOWN,	"Linkdown", 8 },
> +	{ FC_PORTSTATE_ERROR,		"Error", 5 },
> +	{ FC_PORTSTATE_LOOPBACK,	"Loopback", 8 },
> +	{ FC_PORTSTATE_DELETED,		"Deleted", 7 },
> +	{ FC_PORTSTATE_MARGINAL,	"Marginal", 8 },
>  };
>  fc_enum_name_search(port_state, fc_port_state, fc_port_state_names)
> +fc_enum_name_match(port_state, fc_port_state, fc_port_state_names)
>  #define FC_PORTSTATE_MAX_NAMELEN	20
>
>
> @@ -2071,6 +2074,7 @@ fc_eh_timed_out(struct scsi_cmnd *scmd)  {
>  	struct fc_rport *rport = starget_to_rport(scsi_target(scmd-
> >device));
>
> +	fc_rport_chkmarginal_set_noretries(rport, scmd);
>  	if (rport->port_state == FC_PORTSTATE_BLOCKED)
>  		return BLK_EH_RESET_TIMER;
>
> @@ -2095,7 +2099,8 @@ fc_user_scan_tgt(struct Scsi_Host *shost, uint
> channel, uint id, u64 lun)
>  		if (rport->scsi_target_id == -1)
>  			continue;
>
> -		if (rport->port_state != FC_PORTSTATE_ONLINE)
> +		if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +			(rport->port_state != FC_PORTSTATE_MARGINAL))
>  			continue;
>
>  		if ((channel == rport->channel) &&
> @@ -2958,7 +2963,8 @@ fc_remote_port_delete(struct fc_rport  *rport)
>
>  	spin_lock_irqsave(shost->host_lock, flags);
>
> -	if (rport->port_state != FC_PORTSTATE_ONLINE) {
> +	if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +		(rport->port_state != FC_PORTSTATE_MARGINAL)) {
>  		spin_unlock_irqrestore(shost->host_lock, flags);
>  		return;
>  	}
> @@ -3100,7 +3106,8 @@ fc_timeout_deleted_rport(struct work_struct
> *work)
>  	 * target, validate it still is. If not, tear down the
>  	 * scsi_target on it.
>  	 */
> -	if ((rport->port_state == FC_PORTSTATE_ONLINE) &&
> +	if (((rport->port_state == FC_PORTSTATE_ONLINE) ||
> +		(rport->port_state == FC_PORTSTATE_MARGINAL)) &&
>  	    (rport->scsi_target_id != -1) &&
>  	    !(rport->roles & FC_PORT_ROLE_FCP_TARGET)) {
>  		dev_printk(KERN_ERR, &rport->dev,
> @@ -3243,7 +3250,8 @@ fc_scsi_scan_rport(struct work_struct *work)
>  	struct fc_internal *i = to_fc_internal(shost->transportt);
>  	unsigned long flags;
>
> -	if ((rport->port_state == FC_PORTSTATE_ONLINE) &&
> +	if (((rport->port_state == FC_PORTSTATE_ONLINE) ||
> +		(rport->port_state == FC_PORTSTATE_ONLINE)) &&

I think the second line should have been FC_PORTSTATE_MARGINAL.


>  	    (rport->roles & FC_PORT_ROLE_FCP_TARGET) &&
>  	    !(i->f->disable_target_scan)) {
>  		scsi_scan_target(&rport->dev, rport->channel, @@ -3747,7 +3755,8 @@
> static blk_status_t fc_bsg_rport_prep(struct fc_rport *rport)
>  	    !(rport->flags & FC_RPORT_FAST_FAIL_TIMEDOUT))
>  		return BLK_STS_RESOURCE;
>
> -	if (rport->port_state != FC_PORTSTATE_ONLINE)
> +	if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +		(rport->port_state != FC_PORTSTATE_MARGINAL))
>  		return BLK_STS_IOERR;
>
>  	return BLK_STS_OK;
> diff --git a/include/scsi/scsi_transport_fc.h
> b/include/scsi/scsi_transport_fc.h
> index 1c7dd35cb7a0..829bade13b89 100644
> --- a/include/scsi/scsi_transport_fc.h
> +++ b/include/scsi/scsi_transport_fc.h
> @@ -14,6 +14,7 @@
>  #include <linux/bsg-lib.h>
>  #include <asm/unaligned.h>
>  #include <scsi/scsi.h>
> +#include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_netlink.h>
>  #include <scsi/scsi_host.h>
>
> @@ -67,6 +68,7 @@ enum fc_port_state {
>  	FC_PORTSTATE_ERROR,
>  	FC_PORTSTATE_LOOPBACK,
>  	FC_PORTSTATE_DELETED,
> +	FC_PORTSTATE_MARGINAL,
>  };
>
>
> @@ -707,6 +709,22 @@ struct fc_function_template {
>  	unsigned long	disable_target_scan:1;
>  };
>
> +/**
> + * fc_rport_chkmarginal_set_noretries - Set the SCMD_NORETRIES_ABORT
> bit
> + * in cmd->state if port state is marginal
> + * @rport:	remote port to be checked
> + * @scmd:	scsi_cmd to set/clear the SCMD_NORETRIES_ABORT bit on
> Marginal state
> + **/
> +static inline void
> +fc_rport_chkmarginal_set_noretries(struct fc_rport *rport, struct
> scsi_cmnd *cmd)
> +{
> +	if ((rport->port_state == FC_PORTSTATE_MARGINAL) &&
> +		 (cmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT))
> +		set_bit(SCMD_NORETRIES_ABORT, &cmd->state);
> +	else
> +		clear_bit(SCMD_NORETRIES_ABORT, &cmd->state);
> +
> +}
>
>  /**
>   * fc_remote_port_chkready - called to validate the remote port state
> @@ -723,6 +741,7 @@ fc_remote_port_chkready(struct fc_rport *rport)
>
>  	switch (rport->port_state) {
>  	case FC_PORTSTATE_ONLINE:
> +	case FC_PORTSTATE_MARGINAL:
>  		if (rport->roles & FC_PORT_ROLE_FCP_TARGET)
>  			result = 0;
>  		else if (rport->flags & FC_RPORT_DEVLOSS_PENDING)

--000000000000ce163f05b298b670
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCD2jRWJquL1CjMRdqnxOiO+UZtDKMsDA8qSX3z6gpb8qjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEwMjYyMDI0MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAr2RW5MYvVHOru5bP
2BsLr4OUVBWPX8XOtYo19+1hjZOEKgWzE7tMSppePjfyyBEmsMzifdtLAvueOJmHEOxDY7Gsyod6
LCVFznmQucf4On05JLCNhU3M58mkSDBBnz3FbxLs5j8OfWK7uMBwD24Sga6/j1pkkYet0a8iTg3I
iS3u6r/acGI4J5e5cJ/JKhM4vDf268THQoQ1OPrfuU/sosajjlTNktog5B5qi2UnPCSDCyOrB+bT
t7qgPeEJAlkgW5ntcfDTPKRSI347J0Bm85Vj6ANmMk/4Ii5FgJ10oJ0qF9tncg90lR8XyNUtdIYp
IVwshoOCqq9Za1cyC/u3EA==
--000000000000ce163f05b298b670--
