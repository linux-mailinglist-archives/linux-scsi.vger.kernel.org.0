Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D2D4F8E5D
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Apr 2022 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiDHFSh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Apr 2022 01:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiDHFSg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Apr 2022 01:18:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED2360CD5
        for <linux-scsi@vger.kernel.org>; Thu,  7 Apr 2022 22:16:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE04068AFE; Fri,  8 Apr 2022 07:16:29 +0200 (CEST)
Date:   Fri, 8 Apr 2022 07:16:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de
Subject: Re: [PATCH 1/6] scsi_cmnd: reinstate support for cmd_len > 32
Message-ID: <20220408051629.GA31885@lst.de>
References: <20220408035651.6472-1-dgilbert@interlog.com> <20220408035651.6472-2-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408035651.6472-2-dgilbert@interlog.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 07, 2022 at 11:56:46PM -0400, Douglas Gilbert wrote:
> A patch titled "scsi: core: Remove the cmd field from struct
> scsi_request" [ce70fd9a551af] limited the size of a SCSI
> CDB (command descriptor block) to 32 bytes. While this covers
> the current requirements of the sd driver, OSD users and
> those sending long vendor specific cdb_s via the sg or bsg
> drivers will be disappointed by this regression.

And who in particular is that?
