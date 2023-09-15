Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2287A2800
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Sep 2023 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjIOUWi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Sep 2023 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjIOUWM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Sep 2023 16:22:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E398C6
        for <linux-scsi@vger.kernel.org>; Fri, 15 Sep 2023 13:22:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F301E219FB;
        Fri, 15 Sep 2023 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694809320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBaNWuOthRc5kxEbDZB1ncTOTXxAlTJXGSpkTfFxqFk=;
        b=j2mrqWpkNwELm/AunsaFRZ726KeJAj2RZC/ejKLRRG9B3L1gP/EYx4icjLX0BhlJDZziaG
        ASKo53s3h+lR839Thst0ZxjXRfWD6rWwzzHs9tt1hr4CH6qXoAUNacw76HFwewNK3qHyAP
        KQc17iGNM8YYVKfNIp8xUFvZQJ88n8A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB4881358A;
        Fri, 15 Sep 2023 20:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gakhJue8BGV7EAAAMHmgww
        (envelope-from <mwilck@suse.com>); Fri, 15 Sep 2023 20:21:59 +0000
Message-ID: <d3d8bc89e45708cde24912b497348f12c662f45f.camel@suse.com>
Subject: Re: [PATCH v11 07/34] scsi: sd: Have scsi-ml retry read_capacity_16
 errors
From:   Martin Wilck <mwilck@suse.com>
To:     Mike Christie <michael.christie@oracle.com>,
        john.g.garry@oracle.com, bvanassche@acm.org, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Date:   Fri, 15 Sep 2023 22:21:58 +0200
In-Reply-To: <20230905231547.83945-8-michael.christie@oracle.com>
References: <20230905231547.83945-1-michael.christie@oracle.com>
         <20230905231547.83945-8-michael.christie@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2023-09-05 at 18:15 -0500, Mike Christie wrote:
> This has read_capacity_16 have scsi-ml retry errors instead of
> driving
> them itself.
>=20
> There are 2 behavior changes with this patch:
> 1. There is one behavior change where we no longer retry when
> scsi_execute_cmd returns < 0, but we should be ok. We don't need to
> retry
> for failures like the queue being removed, and for the case where
> there
> are no tags/reqs since the block layer waits/retries for us. For
> possible
> memory allocation failures from blk_rq_map_kern we use GFP_NOIO, so
> retrying will probably not help.
> 2. For the specific UAs we checked for and retried, we would get
> READ_CAPACITY_RETRIES_ON_RESET retries plus whatever retries were
> left
> from the loop's retries. Each UA now gets
> READ_CAPACITY_RETRIES_ON_RESET
> reties, and the other errors (not including medium not present) get
> up
> to 3 retries.

This is ok, but - just a thought - would it make sense to add a field
for maximum total retry count (summed over all failures)? That would
allow us to minimize behavior changes also in other cases.

> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Martin Wilck <mwilck@suse.com>

