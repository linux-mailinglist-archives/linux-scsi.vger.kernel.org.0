Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5806D2213
	for <lists+linux-scsi@lfdr.de>; Fri, 31 Mar 2023 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjCaOK2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 Mar 2023 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjCaOK0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 Mar 2023 10:10:26 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791E1E738
        for <linux-scsi@vger.kernel.org>; Fri, 31 Mar 2023 07:10:23 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-544787916d9so416382577b3.13
        for <linux-scsi@vger.kernel.org>; Fri, 31 Mar 2023 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680271822;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=jx5o/zRQSipB+lOnld2KcT34K+G/baT1WBlLs6da1WIIUEjXaHQxUBdcg++4c2HtQq
         kU8Z1gHYdB3HTp/M+8LIJGdKPkxtdH26I5fXrPcd8J9QCX/ypjckklKZV+7WzRm4eIof
         bxo32kRfLQRyVV39pVUaW4Zst6ShOnO/y1pptW3TJnha1f/hyS1eW6DSbMTP9MK6uWI5
         rLx/T8zucWaqMup9+o0g0JT8TkNjD1zLasAC05ey1GD5YS3tOzj1bCHXNmjHn1kQu6p5
         0J994d6ietVEj5BB9nRdIn+tXhDXR/zJen4Fb+N+UkAGIiI2hYhw6pqEC5FqfruclCsa
         KM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680271822;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=A2Q1ln4ywuvxuBgeH/2zeC0WS2lhLe2IPwYyCvn9EGVp1qebL/g394J9pn8zGh22J4
         O9rWlZhuqtOPB1C/XfJ78mHecU7m4moUH6puOzXarF8v1N9kcCKXAxukSL1mg1ygmLXH
         QUe+nXBqcVvPXlS1eUSgcj35oBpel1XiXH4v+W41/8WskILosNS8zrvjL+mP5I27csTf
         YaQTD/xT1FpKMSQ0XMk/rx4cZ239YzP2GdRlqWTJdXHTGo0yrgwlZ3Fe7zwsGRVh8qRB
         okqXChr4MJW09d5U0d3974rMOLteImfExfXiNtyxTgRbNJVOk8+J3AjoJ+Wi2ZntOFqc
         2xsQ==
X-Gm-Message-State: AAQBX9e8Gm60Yvol5P4Qh1pwiHPfw1hCqM5Bz5hTnB8Ic+KK05Y1pajC
        IOfjXSYaM0+lHgEDfafoX7lJ5vPlFf6ac0RnEFA=
X-Google-Smtp-Source: AKy350ZqSYGxDNvzouHUKuHPUIZpCKmcggalyfhxfnYepzZW8JmCIr3+BLCZ7LBpqWJJ2tUub6JwGjqxhCjgPeFtk7I=
X-Received: by 2002:a81:b647:0:b0:541:a17f:c779 with SMTP id
 h7-20020a81b647000000b00541a17fc779mr13767597ywk.4.1680271822514; Fri, 31 Mar
 2023 07:10:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7693:b0:2ea:28fd:9131 with HTTP; Fri, 31 Mar 2023
 07:10:22 -0700 (PDT)
Reply-To: felixglas37@gmail.com
From:   Douglas Felix <legalrightschamber07@gmail.com>
Date:   Fri, 31 Mar 2023 14:10:22 +0000
Message-ID: <CALi75Oo-55EgVs2vVPx0NWLUh0ddVT-hjmCrLJBHrVge2AZ2Lw@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5b6L5biI44CCIOmBk+agvOaLieaWr+iPsuWIqeWFi+aWrw0K
