Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5192561E3D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Jun 2022 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiF3Ojm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Jun 2022 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiF3Oj1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 Jun 2022 10:39:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619971F2F2
        for <linux-scsi@vger.kernel.org>; Thu, 30 Jun 2022 07:38:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cv13so18955702pjb.4
        for <linux-scsi@vger.kernel.org>; Thu, 30 Jun 2022 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=dLRZj7asZCW6B/PsgZa/XpuOtU4vePXttOh7iky7Z54=;
        b=DMWSV6906rdVf0GmB51xJxLvB94nPf026VoWqJVRTe42ioBEe4t8p4Q+7RhS4OPPaY
         6eWd4H0P8LmhKbRCs3gE95b/BS/u9bKbNe9bt/UlAQZw2+44hgtREKXs5ZbB/2Qb40XD
         1H4EFjs7n6U3JFYzkcN+U4zt+YlTxMlM9ej4TqaEKP83jiAEe6jLObg06nwohOFE+/L/
         xFqRqa1MyathJDfCy3Zr2jaHvahKJneLAULZ+SogGnOfxMXDIOAD8Oq5PpVJaRNxnaTr
         cFNQK/voVessDMPhyajGVSOXiLWJhXbvaGcmBLSpweJbXRkLH7sqGOLeeNkngS+2VB8a
         /ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=dLRZj7asZCW6B/PsgZa/XpuOtU4vePXttOh7iky7Z54=;
        b=B/lBL5Kmg1PbzpdWzSMUjQY6y7ftbBrdke/HnCLIl1h5LNn5WVh1K1FrNdqPV8e0zr
         5HPG2sLvZ9rFe+eygbPGJWttW6yCvFJC75VcKcGdlRAB/yXWFAUNulHKVyj7ndEi/y+B
         qF0198uGfeSOMtsRTj95ZInkcY5fnaHFOBaU8W8VXPYwt7bUL2XfDsjVWDBaWT9iuCTX
         rAi9K+rIj2liyheL5VfxXsuiep/jsATFGYCJwXdPq3jbTQHy1QAjx+ob6ltKuNmesH8O
         H4WMHHoS14c1ttDOUqi1/8fkI5nxfl4PJVaKo3Le3AlmPoy2TZKACLmVN4RSji5dpxBF
         zGoA==
X-Gm-Message-State: AJIora9h61/U6d26WatjN3oSTiOvHOuKomgyrgtCd1XQVhTR5mW1lN5L
        MLwaj7D/bLMmFGzws55eP3lojZPmlVjB/W9OGh4=
X-Google-Smtp-Source: AGRyM1ucDEnscyZ+teNg4Lo/1AweIpmcYQ0Z+U1U5bkVTUY7C4pho+0ClXp9CbPI2KJWV6o5BhJpD1eUQBfI1nAZFbg=
X-Received: by 2002:a17:902:cec1:b0:16a:5e81:c31b with SMTP id
 d1-20020a170902cec100b0016a5e81c31bmr16622102plg.136.1656599910974; Thu, 30
 Jun 2022 07:38:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: aichatouaboubacar16@gmail.com
Received: by 2002:a05:6a10:6f20:b0:2b3:579a:ac46 with HTTP; Thu, 30 Jun 2022
 07:38:30 -0700 (PDT)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Thu, 30 Jun 2022 07:38:30 -0700
X-Google-Sender-Auth: g9rrsx5HNhcGvudhA79HRcnHdJ0
Message-ID: <CAGoASREFZizyKA0cz4x46kXB4SgJRfyGW-bdaAjSLJL5Fm8b4A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

pozdrav, jesi li dobio moje prethodne mailove? molim provjerite i odgovorite mi
