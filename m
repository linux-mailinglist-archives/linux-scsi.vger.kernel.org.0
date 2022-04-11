Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91C4FB320
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 07:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiDKFFn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Apr 2022 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDKFFm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Apr 2022 01:05:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72933B00C
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 22:03:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95D7368AFE; Mon, 11 Apr 2022 07:03:25 +0200 (CEST)
Date:   Mon, 11 Apr 2022 07:03:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de
Subject: Re: [PATCH v2 0/6] scsi: fix scsi_cmd::cmd_len
Message-ID: <20220411050325.GA13927@lst.de>
References: <20220410173652.313016-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410173652.313016-1-dgilbert@interlog.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This still misses any good explanation of why we want all this.
