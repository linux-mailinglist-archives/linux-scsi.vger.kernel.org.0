Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD6421B4E
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Oct 2021 02:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhJEAzX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Oct 2021 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEAzW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Oct 2021 20:55:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B6EC061749
        for <linux-scsi@vger.kernel.org>; Mon,  4 Oct 2021 17:53:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id z3so4284546qvl.9
        for <linux-scsi@vger.kernel.org>; Mon, 04 Oct 2021 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=daqKtCmZwt0yPi/B3/buyoq8Sig2UsGnZMeMExRdBQeAd9u14RnQyoo8801lGA03We
         J1gf0xzFKOVo2xvJc4xHutx1mL6lMTPsH3JXul+AVvG3oOZ1ysTE8KUEYUdsu3YVcTPm
         6ROTmH7RKJFL+ELionxJST5CLo92anJW/7xbJ+fWHHyIg4YAwP4mWWpYAsswOLJnbJG7
         SSuvBoQXYdnJU24NMfoEVKuUx4HM15op4kOxiAci0vVu3i0NhR1t5l5ThDdXBlOY5nqN
         uHZIhTje08ecrFUNaWLTtB8/PHmw77v5JGKr8gdwCicAjMDUqDBHltcipkAcqZ01GbtI
         iUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=a/eyjgVuJ5j/DDL2y1GLA1BmQ2IzwDu+ggQkhKYFIOUR1BUbMjRP3CNzJRqNSBqVvb
         MUrBuCz2GYE3T7rxNpQcfY5+g2hvqQN/NdcYwsKre/WNe6ceZ9kmqTM+Pmf958jXSK3b
         VnaUOyBtZLg8ftSmAAZsDKuenKq1wVwpePRGEEWQ1TnQImHvpIyakINeX1RVmQx8roBK
         uFQvvybBuj6k2mj/7VYyOK1osvQxdqU5ergtJJgMbyPRalVO9OF3lM+6jfdkzho9tXof
         oYYCI8tjQEerIcX5Ut7bXwlb2PfEOvr46aIcyLDBP5ihl+voKF6rrq9aXer9W6XiUdDs
         aSAg==
X-Gm-Message-State: AOAM5325OyOuWFeGqrylb04jjzyNniEMTiBucdBPI3CDb2G/vEm5qKyr
        9rAPvdIKsp7tZAJunSNBXMbOxzqSnhv8KcsSyyA=
X-Google-Smtp-Source: ABdhPJz3NxXJrQS3J3G6TGFb6FiCzpHx/FKk7Z8ivJPmwrG0Ooobv9+A+EmGvHlANXl6nbq9SCKKSG180ZoOKpWFuzE=
X-Received: by 2002:a0c:8e45:: with SMTP id w5mr24562097qvb.17.1633395212247;
 Mon, 04 Oct 2021 17:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:45cb:0:0:0:0:0 with HTTP; Mon, 4 Oct 2021 17:53:31 -0700 (PDT)
Reply-To: cherrykona25@hotmail.com
From:   Cherry Kona <fernadezl768@gmail.com>
Date:   Mon, 4 Oct 2021 17:53:31 -0700
Message-ID: <CA+J-fD4eR7XrmVwq7u-DR_u5PASVEW+dwUMBmgepF3UVnDDNNg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
You see my message i sent to you?
