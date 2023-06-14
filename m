Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5E7264D1
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Jun 2023 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjFGPia (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Jun 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjFGPi3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Jun 2023 11:38:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3A125;
        Wed,  7 Jun 2023 08:38:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A15301FDAF;
        Wed,  7 Jun 2023 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686152307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kkwlk03GZO5nENrvtVROVto9i8M8yZ82CN7aOAB3zBw=;
        b=KWv3E76mWyJniU27FhrjPpLJqpUZJXMFdDhPUCg8YC2G3mUnPWyUMAzU9zVP9soTrW1SHk
        QdazOR4d+s9rQxUaaJ/9eT9fojTAi9rKTC29Erbv6x5cQTihROytFlzvj9AOBUNwaK9pC4
        LhAODKpUNBz566fNxokekBwQHRoUhpM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EBAE1346D;
        Wed,  7 Jun 2023 15:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HYRoDXOkgGRsNAAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 07 Jun 2023 15:38:27 +0000
Message-ID: <7ee70331d921854e2b27de3d072d0d8f8ce97f3b.camel@suse.com>
Subject: Re: [PATCH v2 3/3] scsi: simplify scsi_stop_queue()
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Date:   Wed, 07 Jun 2023 17:38:26 +0200
In-Reply-To: <903c7222-c95e-fda1-9b90-b59e184944cf@acm.org>
References: <20230606193845.9627-1-mwilck@suse.com>
         <20230606193845.9627-4-mwilck@suse.com> <20230607052710.GC20052@lst.de>
         <c0563161eb613f9500e6a1cccdcff6fc64efffad.camel@suse.com>
         <903c7222-c95e-fda1-9b90-b59e184944cf@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2023-06-07 at 07:05 -0700, Bart Van Assche wrote:
> On 6/7/23 02:26, Martin Wilck wrote:
> > On Wed, 2023-06-07 at 07:27 +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 06, 2023 at 09:38:45PM +0200, mwilck@suse.com=A0wrote:
> > > > =A0=A0scsi_target_block(struct device *dev)
> > > > =A0=A0{
> > > > +=A0=A0=A0=A0=A0=A0=A0struct Scsi_Host *shost =3D dev_to_shost(dev)=
;
> > > > +
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0if (scsi_is_target_device(dev))
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0starget_for_each=
_device(to_scsi_target(dev),
> > > > NULL,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device_block);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0else
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device_for_each_=
child(dev, NULL,
> > > > target_block);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0/* Wait for ongoing scsi_queue_rq() calls to =
finish. */
> > > > +=A0=A0=A0=A0=A0=A0=A0if (!WARN_ON_ONCE(!shost))
> > >=20
> > > How could host ever be NULL here?=A0 I can't see why we'd want this
> > > check.
> >=20
> > The reason is simple: I wasn't certain if dev_to_shost() could
> > return
> > NULL, and preferred skipping the wait over an Oops. I hear you say
> > that
> > dev_to_shost() can't go wrong, so I'll remove the NULL test.
>=20
> I propose to pass shost as the first argument to scsi_target_block()=20
> instead of using dev_to_shost() inside scsi_target_block(). Except in
> __iscsi_block_session(), shost is already available as a local
> variable.

If we do this, it might actually be cleaner to just pass the tag set to
wait for.

Martin

