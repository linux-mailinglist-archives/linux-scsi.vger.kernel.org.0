Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638645EF746
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Sep 2022 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiI2ON2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Sep 2022 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiI2ONZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Sep 2022 10:13:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C21B8687
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 07:13:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 923D32189C;
        Thu, 29 Sep 2022 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664460802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U49k6+NWaxmQG7rz+tTdOPBp9QAGweACa79Ho9s7SxA=;
        b=M/ur+Wo4e75EJNgOoxajQhoyLjGBmThB1KNSh/ehVaSHR0MaAepBsNnjsUmhnpDJ+0EKGE
        Q1kQBZURZ6qSKtOszu3D/CoSbyRUzGt+WGKhgWCcSJ3YNlcrngldMVFxfIa5CQigNnufjP
        V9o2yGNJ/55MlAru6+MeeXaEKADBaYY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54EA013A71;
        Thu, 29 Sep 2022 14:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EeJEgKoNWM2OwAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 29 Sep 2022 14:13:22 +0000
Message-ID: <80aa76848bb316781953775922e3509410734dd6.camel@suse.com>
Subject: Re: [PATCH v2 23/35] scsi: Have scsi-ml retry sd_spinup_disk errors
From:   Martin Wilck <mwilck@suse.com>
To:     Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Date:   Thu, 29 Sep 2022 16:13:21 +0200
In-Reply-To: <20220929025407.119804-24-michael.christie@oracle.com>
References: <20220929025407.119804-1-michael.christie@oracle.com>
         <20220929025407.119804-24-michael.christie@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2022-09-28 at 21:53 -0500, Mike Christie wrote:
> This simplifies sd_spinup_disk so scsi-ml retries errors for it. Note
> that
> we retried specifically on a UA and also if scsi_status_is_good
> returned
> failed which could happen for all check conditions, so in this patch
> we
> don't check for only UAs.
>=20
> We do not handle the outside loop's retries because we want to sleep
> between tried and we don't support that yet.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
> =A0drivers/scsi/sd.c | 76 ++++++++++++++++++++++++++++-----------------
> --
> =A01 file changed, 45 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a35c089c3097..716e0c8ffa57 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2064,50 +2064,64 @@ sd_spinup_disk(struct scsi_disk *sdkp)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned char cmd[10];
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long spintime_expire =3D 0;
> -=A0=A0=A0=A0=A0=A0=A0int retries, spintime;
> +=A0=A0=A0=A0=A0=A0=A0int spintime;
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned int the_result;
> =A0=A0=A0=A0=A0=A0=A0=A0struct scsi_sense_hdr sshdr;
> =A0=A0=A0=A0=A0=A0=A0=A0int sense_valid =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0struct scsi_failure failures[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.se=
nse =3D SCMD_FAILURE_SENSE_ANY,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.as=
c =3D SCMD_FAILURE_ASC_ANY,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.as=
cq =3D SCMD_FAILURE_ASCQ_ANY,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.al=
lowed =3D 3,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.re=
sult =3D SAM_STAT_CHECK_CONDITION,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0},
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
Retry scsi status and host errors that
> return
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
failure in scsi_status_is_good.
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.re=
sult =3D SAM_STAT_BUSY |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SAM_STAT_RESERVATION_CONFLICT |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SAM_STAT_TASK_SET_FULL |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SAM_STAT_ACA_ACTIVE |
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SAM_STAT_TASK_ABORTED |

I fail to understand how bitwise-or would work here. IIUC, this tries
to replicate the logic to retry if (!scsi_status_is_good()). The result
of this bitwise-or operation is 0x78, which matches all SAM_ codes
except SAM_STAT_GOOD, SAM_STAT_CHECK_CONDITION and
SAM_STAT_CONDITION_MET. SAM_STAT_CHECK_CONDITION is covered by the
first failure. But unless I'm mistaken, we'd now retry on
SAM_STAT_INTERMEDIATE, SAM_STAT_INTERMEDIATE_CONDITION_MET, and
SAM_STAT_COMMAND_TERMINATED, on which the old code did not retry. Am I
overlooking something?

At least this deserves an in-depth comment; in general, as noted
for patch 02/35, I find using bitwise or for SAM status counter-
intuitive.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 DID_NO_CONNECT << 16,

Shouldn't .allowed be set to 3 here? OTOH that would cause the number
of retries to add up to 6, see my reply to 22/35. But don't see what
effect a failure with allowed =3D 0 would have.


Regards
Martin

