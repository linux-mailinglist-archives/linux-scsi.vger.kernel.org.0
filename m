Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8D7CBB6C
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Oct 2023 08:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjJQGiC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Oct 2023 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQGiB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Oct 2023 02:38:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827A95
        for <linux-scsi@vger.kernel.org>; Mon, 16 Oct 2023 23:38:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B75A968BFE; Tue, 17 Oct 2023 08:37:57 +0200 (CEST)
Date:   Tue, 17 Oct 2023 08:37:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 16/17] csiostor: use separate TMF command
Message-ID: <20231017063757.GB9048@lst.de>
References: <20231016092430.55557-1-hare@suse.de> <20231016092430.55557-17-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016092430.55557-17-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
