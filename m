Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB51F886A
	for <lists+linux-scsi@lfdr.de>; Sun, 14 Jun 2020 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFNKe1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 14 Jun 2020 06:34:27 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47651 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725265AbgFNKeY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 14 Jun 2020 06:34:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 614D958023B;
        Sun, 14 Jun 2020 06:34:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 14 Jun 2020 06:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boo.tc; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=c
        T4DLrJqcF3AZNwx/h9teF9k/KdmITBW6mDn7iJQ924=; b=U0fJhpnS5Fa5GPcNG
        mXyUWW8AakNG0V+t1eoUKvdp39D0bAMoPJVSXE7KXNqWILsjZ3NPPRos9yBI/YYn
        8U7JQNL0+roTfwWE5103O4EATs1ZN+hjrAkraBmDJmUmgMTJ+qau5yocvnc0xhID
        OfpRKu6RSIXW0qgzsEzxK3z+jja6BhM2ehbOX46YpOIwRbak7EeSod8EY5uptl8M
        Nu8fEOe4sqX7aCs+uyrljUhmLG9kE/aAxE60o3n4YOWc3HdvGT8hX4AOdy34511f
        I+m5IhD9x2khvtjOqol6C24WHp6gBeRfgxyb0IwioEGNaGGHIYs8IHdtXHfVyPk7
        ePR7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=cT4DLrJqcF3AZNwx/h9teF9k/KdmITBW6mDn7iJQ9
        24=; b=QzKF7G236FYpBybYsxCuH4RGw1HsYiA5c5Cl+zDPFE9JD7JZbkDBAzOdY
        JiuZDmA6nf+rzNXg+YFsBJADhAg+/CqXc8rF/umsjhuy5e8xdTyARf+zEcazv/4X
        UsECcXKfWakyT2I4wmtx10azgycJoR58PcLh1WjFCH3og6eMWYAMvjiDDyu11C37
        SrOc/w7i/AisndFCyJb/PVoAfZEKwnvBY4blysM1zJuAItINTQEyz6S1L/Qbe2Nr
        a8MuEcigpUbUeix0DVKHb4pDDhUrs33IB3zhgc7JNiv+LM2UC4j340OErICwB9fI
        7I47iczoqOSF5rqv+E5KHqCYHQ41Q==
X-ME-Sender: <xms:Lf3lXqn4AxO4zix686EioHM9n9fI4Tq3qcs6cAkJUboxXU68rs23Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdehmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddt
    feejnecuhfhrohhmpeevhhhrihhsuceuohhothcuoegsohhothgtsegsohhordhttgeqne
    cuggftrfgrthhtvghrnhepteeugfevhffhudegteevkedvlefhhfelvdfhuedvkeefudfh
    hfdvheegffefuddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkedurd
    dukeejrdehhedrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoohhttgessghoohdrthgt
X-ME-Proxy: <xmx:Lf3lXh3S2ruGN7mKk4U_R1X2xQb7vSEph3xYHj4OVbOD-9uaJ25t_Q>
    <xmx:Lf3lXorcDWVqa1BL7wvXafCXzjmttID2c0htvYVbpCZ-a93-IRkFGw>
    <xmx:Lf3lXulOJrux8VPGKGUtmWNbXeVBm-D3wNLZ5WNlZmPLZkJOzG1-rQ>
    <xmx:Lv3lXpL7dKrs-rUoOodHOKHdNJd-XflRo-NPjcFZ5r1aswWPBetbiQ>
Received: from heen.boo.tc (heen.boo.tc [81.187.55.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59CFC328005D;
        Sun, 14 Jun 2020 06:34:20 -0400 (EDT)
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
To:     Finn Thain <fthain@telegraphics.com.au>,
        Chris Boot <bootc@bootc.net>
Cc:     linuxppc-dev@lists.ozlabs.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>
 <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet>
From:   Chris Boot <bootc@boo.tc>
Autocrypt: addr=bootc@boo.tc; prefer-encrypt=mutual;
 keydata= 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
 1QBDj3S+cCP/8Pe5l3n1B7V4SkVPBQs/H/ClB6o=
Message-ID: <7ad14946-5c25-fc49-1e48-72d37a607832@boo.tc>
Date:   Sun, 14 Jun 2020 11:34:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/06/2020 01:03, Finn Thain wrote:
> On Sat, 13 Jun 2020, Chris Boot wrote:
> 
>> I no longer have the time to maintain this subsystem nor the hardware to
>> test patches with. 
> 
> Then why not patch MAINTAINERS, and orphan it, as per usual practice?
> 
> $ git log --oneline MAINTAINERS | grep -i orphan

My patch to remove it was in response to:

https://lore.kernel.org/lkml/yq1img99d4k.fsf@ca-mkp.ca.oracle.com/

>> It also doesn't appear to have any active users so I doubt anyone will 
>> miss it.
>>
> 
> It's not unusual that any Linux driver written more than 5 years ago 
> "doesn't appear to have any active users".
> 
> If a driver has been orphaned and broken in the past, and no-one stepped 
> up to fix it within a reasonable period, removal would make sense. But 
> that's not the case here.
> 
> I haven't used this driver for a long time, but I still own PowerMacs with 
> firewire, and I know I'm not the only one.

I expect that if someone finds this useful it can stick around (but
that's not my call). I just don't have the time or inclination or
hardware to be able to maintain it anymore, so someone else would have
to pick it up.

Cheers,
Chris

-- 
Chris Boot
bootc@boo.tc
